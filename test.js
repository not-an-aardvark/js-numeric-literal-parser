'use strict';

const assert = require('assert');
const { parse, SyntaxError } = require('.');
const testCases = require('./test-cases.json');

describe('parsing', () => {
  describe('valid', () => {
    Object.keys(testCases.valid).forEach(input => {
      it(input, () => {
        assert.deepStrictEqual(parse(input), testCases.valid[input])
      });
    });
  });
  describe('invalid', () => {
    testCases.invalid.forEach(input => {
      it(input, () => {
        assert.throws(() => parse(input), SyntaxError);
      });
    });
  });
});
