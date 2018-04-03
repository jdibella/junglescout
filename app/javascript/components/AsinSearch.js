import React from "react"
import PropTypes from "prop-types"
import {Row, Col, Input, Button, Icon, Card} from 'react-materialize'
class AsinSearch extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      asin: "", searched: false, product: null, reviews: [], reviewsPage: 1
    };
  }

  handleSearch = (event, value) => {
    this.setState({asin: value.trim()});
  };

  submit = (event) => {
    event.preventDefault();
    $.getJSON("/api/v1/info/" + this.state.asin)
      .done((data) => { this.receiveProduct(data); });
  };

  receiveProduct(json) {
    this.setState({ product: json, searched: true });
  }

  receiveReviews(json) {
    let reviews = this.state.reviews;
    json.forEach( (elm) => {
      reviews.push(elm);
    });
    this.setState({ reviews: reviews, reviewsPage: this.state.reviewsPage + 1 });
  }

  handleReviews = (event) => {
    event.preventDefault();
    $.getJSON("/api/v1/info/" + this.state.asin + "/reviews?page=" + this.state.reviewsPage)
      .done((data) => { this.receiveReviews(data); });
  };

  render() {
    const searched = this.state.searched;
    let card = null;
    let reviewList = null

    if (searched) {
      const rank = this.state.product.product_ranking.rank;
      const category = this.state.product.product_ranking.category;
      let reviewsList = this.state.reviews.map((review) => {
        return (
          <tr>
            <td>{review.author}</td>
            <td>{review.rating}</td>
            <td>{review.body}</td>
          </tr>
        );
      });
      let seeReviewsText = "See Reviews";
      if (this.state.reviews.length > 0) {
        seeReviewsText = "See More Reviews"
      }
      card = (
        <Row>
          <Col s={10} offset="s1">
            <Card
              id="productCard" className="large" title={this.state.product.title}
              actions={[<a href="#" onClick={this.handleReviews}>{seeReviewsText}</a>]}
            >
              <p>
                Rank: # {rank} in {category}
              </p>

              <table>
                <thead>
                  <tr><th>Author</th><th>Rating</th><th>Review</th></tr>
                </thead>
                <tbody>
                  {reviewsList}
                </tbody>
              </table>
            </Card>
          </Col>
        </Row>
      );
    }
    return (
      <Row>
        <Row id="asin-search-container">
          <Col s={10} offset="s1">
            <Row>
              <Col s={12}>
                <form>
                  <Input
                    placeholder="Amazon ASIN, ex: B002QYW8LW" s={12}
                    label="Amazon ASIN" name="asin"
                    onChange={this.handleSearch}/>

                  <Button waves='light' onClick={this.submit}>Look up<Icon left>search</Icon></Button>
                </form>
              </Col>
            </Row>
          </Col>
        </Row>
        {card}
      </Row>
    );
  }
}
export default AsinSearch
