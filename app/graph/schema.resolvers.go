package graph

// This file will be automatically regenerated based on the schema, any resolver implementations
// will be copied through when generating and any unknown code will be moved to the end.

import (
	"context"
	"fmt"
	"math/rand"

	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/thundercats-after-dark/introspection-api/app/graph/generated"
	model2 "github.com/thundercats-after-dark/introspection-api/app/graph/model"
)

func (r *mutationResolver) CreateTodo(ctx context.Context, input model2.NewTodo) (*model2.Todo, error) {
	todo := &model2.Todo{
		ID:     fmt.Sprintf("T%d", rand.Int()),
		Text:   input.Text,
		UserID: input.UserID,
		User: &model2.User{
			ID:   input.UserID,
			Name: "user " + input.UserID,
		},
	}
	r.todos = append(r.todos, todo)
	return todo, nil
}

func (r *queryResolver) Todos(ctx context.Context) ([]*model2.Todo, error) {
	return r.todos, nil
}

func (r *queryResolver) DynamoTables(ctx context.Context) ([]*model2.DynamoTable, error) {
	p := dynamodb.NewListTablesPaginator(r.DynamoDBClient, nil, func(o *dynamodb.ListTablesPaginatorOptions) {
		o.StopOnDuplicateToken = true
	})

	var result []*model2.DynamoTable
	for p.HasMorePages() {
		out, err := p.NextPage(ctx)
		if err != nil {
			return []*model2.DynamoTable{}, err
		}

		for _, tableName := range out.TableNames {
			result = append(result, &model2.DynamoTable{Name: tableName})
		}
	}

	return result, nil
}

func (r *queryResolver) People(ctx context.Context) ([]*model2.Person, error) {

	var result []*model2.Person

	// result = append(result, &model.Person{
	// 	Email: "me@here.com",
	// 	Name:  PointerOf("Chad McElligott"),
	// }, &model.Person{
	// 	Email: "monkeymoo@foo.com",
	// 	Name:  PointerOf("Avery Anne Seifried-McElligott"),
	// })
	return result, nil
}

func (r *todoResolver) User(ctx context.Context, obj *model2.Todo) (*model2.User, error) {
	return &model2.User{
		ID:   obj.UserID,
		Name: "user" + obj.UserID,
	}, nil
}

// Mutation returns generated.MutationResolver implementation.
func (r *Resolver) Mutation() generated.MutationResolver { return &mutationResolver{r} }

// Query returns generated.QueryResolver implementation.
func (r *Resolver) Query() generated.QueryResolver { return &queryResolver{r} }

// Todo returns generated.TodoResolver implementation.
func (r *Resolver) Todo() generated.TodoResolver { return &todoResolver{r} }

type mutationResolver struct{ *Resolver }
type queryResolver struct{ *Resolver }
type todoResolver struct{ *Resolver }
