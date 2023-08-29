#!/bin/bash
input="repolist_input.txt"

i=1
at=@
while read line || [ -n "$line" ]; do
  echo "$i: $line"
  position=1
  while IFS='|' read -ra ADDR; do
    for item in "${ADDR[@]}"; do            
      case $position in
        1)
          echo "  - Repository URL: $item"          
          REPO_BASE=${item#*$at}
          REPO_NAME=${item##*/}
          echo "      Base URL       : $REPO_BASE"
          echo "      Repository name: $REPO_NAME"
          ;;
        2)
          echo "  - Event Listener: $item"
          EVENT_LISTENER=$item
          ;;
        3)
          echo "  - Branches      : $item"          
          ;;
        *)
          echo "  wat? (PROPER ERROR HANDLING NEEDED)"
          ;;
      esac
      ((position=position+1))
    done    
  done <<< "$line"
  ((i=i+1))
done < "$input"

