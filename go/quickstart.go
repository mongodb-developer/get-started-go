package main

import (
	"context"
	"fmt"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"log"
	"os"
	"time"
)

type MyAggResult struct {
	Id    string  `bson:"_id"`
	Total float64 `bson:"total"`
}

func main() {
	mongoURI := os.Getenv("MONGODB_URI")
	client, err := mongo.NewClient(options.Client().ApplyURI(mongoURI))
	if err != nil {
		log.Fatal(err)
	}

	ctx, cancel := context.WithTimeout(context.Background(), 3*time.Second)
	defer cancel()
	err = client.Connect(ctx)
	if err != nil {
		panic(err)
	}
	defer client.Disconnect(ctx)

	database := client.Database("quickstart")
	collection := database.Collection("golang")

	fmt.Println("Dropping collection 'golang' (command)")
	result := database.RunCommand(
		context.Background(),
		bson.D{{"drop", "golang"}},
	)
	fmt.Println(result)

	fmt.Println("Inserting a single document.")
	res1, err := collection.InsertOne(
		context.Background(),
		bson.D{
			{"name", "MongoDB"},
			{"type", "database"},
			{"count", 1},
			{"tags", bson.A{"webscale"}},
			{"info", bson.D{
				{"x", 203},
				{"y", 102},
				{"z", "N/A"},
			}},
		})

	if err != nil {
		log.Fatal(err)
	}
	id := res1.InsertedID
	fmt.Println(id)

	fmt.Println("Inserting multiple documents.")
	_, err = collection.InsertMany(
		context.Background(),
		[]interface{}{
			bson.D{
				{"item", "journal"},
				{"qty", 25},
				{"tags", bson.A{"blank", "red"}},
				{"size", bson.D{
					{"h", 14},
					{"w", 21},
					{"uom", "cm"},
				}},
			},
			bson.D{
				{"item", "mat"},
				{"qty", 25},
				{"tags", bson.A{"gray"}},
				{"size", bson.D{
					{"h", 27.9},
					{"w", 35.5},
					{"uom", "cm"},
				}},
			},
		})
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("Iterating over a collection with Find()")
	cur, err := collection.Find(context.Background(), bson.D{})
	if err != nil {
		log.Fatal(err)
	}
	defer cur.Close(context.Background())
	for cur.Next(context.Background()) {
		doc := bson.D{}
		err := cur.Decode(&doc)
		if err != nil {
			fmt.Println("Failed to decode bytes")
			log.Fatal(err)
		}
		fmt.Println(doc)
	}
	if err := cur.Err(); err != nil {
		log.Fatal(err)
	}

	upResult, err := collection.UpdateOne(
		context.Background(),
		bson.M{"item": "journal"},
		bson.M{"$set": bson.M{"qty": 100}},
	)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(upResult)

	delResult, err := collection.DeleteOne(
		context.Background(),
		bson.M{"item": "journal"},
	)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(delResult)

	pipeline := mongo.Pipeline{
		{{"$group", bson.D{
			{"_id", "null"},
			{"total", bson.D{{"$sum", "$info.x"}}},
		}}},
	}
	fmt.Println(pipeline)
	cursor, err := collection.Aggregate(context.Background(), pipeline)
	defer cursor.Close(context.Background())
	for cursor.Next(context.Background()) {
		doc := new(MyAggResult)
		err := cursor.Decode(doc)
		if err != nil {
			log.Fatal(err)
		}
		fmt.Println(doc)
	}
	fmt.Println("Finished.")
}
