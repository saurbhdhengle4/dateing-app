#!/usr/bin/env python3
"""
Remove all comments from Dart files.
Handles:
- Single-line comments: //
- Multi-line comments: /* */
- Documentation comments: ///
- Preserves content inside string literals
"""

import os
import re
import sys

def remove_comments(content):
    result = []
    i = 0
    length = len(content)
    
    while i < length:
        # Check for string literals
        if content[i] in ('"', "'"):
            quote = content[i]
            result.append(content[i])
            i += 1
            
            # Handle triple quotes
            if i + 1 < length and content[i] == quote and content[i+1] == quote:
                result.append(content[i])
                result.append(content[i+1])
                i += 2
                # Read until closing triple quote
                while i < length:
                    if content[i] == quote and i + 2 < length and content[i+1] == quote and content[i+2] == quote:
                        result.append(content[i])
                        result.append(content[i+1])
                        result.append(content[i+2])
                        i += 3
                        break
                    result.append(content[i])
                    i += 1
            else:
                # Read until closing quote (handle escapes)
                while i < length:
                    if content[i] == '\\' and i + 1 < length:
                        result.append(content[i])
                        result.append(content[i+1])
                        i += 2
                    elif content[i] == quote:
                        result.append(content[i])
                        i += 1
                        break
                    else:
                        result.append(content[i])
                        i += 1
        # Check for multi-line comment /* */
        elif content[i] == '/' and i + 1 < length and content[i+1] == '*':
            i += 2
            while i < length:
                if content[i] == '*' and i + 1 < length and content[i+1] == '/':
                    i += 2
                    break
                i += 1
        # Check for single-line comment // or ///
        elif content[i] == '/' and i + 1 < length and content[i+1] == '/':
            # Skip until end of line
            while i < length and content[i] != '\n':
                i += 1
        else:
            result.append(content[i])
            i += 1
    
    return ''.join(result)

def process_file(filepath):
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        new_content = remove_comments(content)
        
        if new_content != content:
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f"Updated: {filepath}")
        else:
            print(f"No changes: {filepath}")
    except Exception as e:
        print(f"Error processing {filepath}: {e}")

def main():
    lib_dir = 'lib'
    
    for root, dirs, files in os.walk(lib_dir):
        for file in files:
            if file.endswith('.dart'):
                filepath = os.path.join(root, file)
                process_file(filepath)

if __name__ == '__main__':
    main()
