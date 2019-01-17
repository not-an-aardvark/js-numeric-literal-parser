# numeric-literal-parser

A parser for JavaScript numeric literals

```bash
$ npm install numeric-literal-parser
```

```js
const parser = require('numeric-literal-parser');

parser.parse('0XdeadBEEF');
/* Output:
   {
     type: 'HexInteger',
     prefix: '0X',
     digits: [ 'd', 'e', 'a', 'd', 'B', 'E', 'E', 'F' ]
   } */
```

## Goals

* Correctness: Parse trees should be correct according to the TC39 spec, including Annex B.
* Full Information: Parse trees should have enough information to reproduce the input string. (This parser is intended for static analysis tools, and it's difficult to determine what aspect of the literal a particular tool might care about, so nothing is omitted.)

## API

This module exports an object with two properties: `parse` and `SyntaxError`. `parse` is a function that accepts a string and returns a parse tree if the parse was successful, or throws an instance of `SyntaxError` if the parse was unsuccessful. 

Parse trees have the following type:

```typescript
type ParseTree =
  {
    type: 'Decimal',
    integralDigits: string[],
    decimalPoint: '.' | null,
    fractionalDigits: string[],
    exponent: {
      exponentIndicator: 'e' | 'E',
      sign: '+' | '-' | null,
      digits: string[]
    } | null
  } |
  {
    type: 'BinaryInteger',
    prefix: '0b' | '0B',
    digits: string[]
  } |
  {
    type: 'OctalInteger',
    prefix: '0o' | '0O',
    digits: string[]
  } |
  {
    type: 'HexInteger',
    prefix: '0x' | '0X',
    digits: string[]
  } |
  {
    type: 'LegacyOctalInteger',
    prefix: '0',
    digits: string[]
  };
```

Literals are parsed for "sloppy mode" JS. To parse a literal for strict mode JS, run the parser and then throw an error manually if

* the parse tree has type `LegacyOctalInteger`, or 
* the parse tree has type `Decimal` and multiple integral digits, the first of which is `'0'`.

## Development

The parser specification in `grammar.pegjs`. Run `npm run build` to generate the JavaScript module.

## License

MIT License
