Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <970893-15443>; Sat, 18 Jul 1998 12:14:35 -0400
Received: from [207.181.251.162] ([207.181.251.162]:14451 "EHLO bitmover.com" ident: "root") by vger.rutgers.edu with ESMTP id <970880-15443>; Sat, 18 Jul 1998 12:14:28 -0400
Message-Id: <199807181734.KAA08309@bitmover.com>
To: linux-kernel@vger.rutgers.edu
From: lm@bitmover.com (Larry McVoy)
Subject: Re: [lm@bitmover.com: Linux performance vs IRIX performance] 
Date: Sat, 18 Jul 1998 10:34:01 -0600
Sender: owner-linux-kernel@vger.rutgers.edu

: > doesn't have, etc, etc.  None the less, it is likely that Linux on the same
: > hardware would be about 3 times faster than IRIX.  
: 
: Larry did not say what kind of FS he used on the Irix box (XFS or EFS), but
: for me it looks like a typical sync metadata/async metadata comparison.

It was XFS.  The other way to be sure, I think, is that if it was a meta
update problem only, then the system times shouldn't be dramatically different.
Disk I/O is not that expensive.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.altern.org/andrebalsa/doc/lkml-faq.html
