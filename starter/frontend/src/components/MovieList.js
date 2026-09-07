import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';

function MovieList({ onMovieClick }) {
  const [movies, setMovies] = useState([]);

  useEffect(() => {
    const backendUrl = "http://a42a20cafe6054347ac993453fdba15d-903599057.us-east-1.elb.amazonaws.com";
    axios.get(`${backendUrl}/movies`).then((response) => {
      setMovies(response.data.movies);
    }).catch((err) => {
      console.error("Failed to fetch movies:", err);
    });
  }, []);

  return (
    <ul>
      {movies.map((movie) => (
        <li className="movieItem" key={movie.id} onClick={() => onMovieClick(movie)}>
          {movie.title}
        </li>
      ))}
    </ul>
  );
}

MovieList.propTypes = {
  onMovieClick: PropTypes.func.isRequired,
};

export default MovieList;