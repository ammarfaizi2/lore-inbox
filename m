Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <154220-19608>; Mon, 25 Jan 1999 01:44:20 -0500
Received: by vger.rutgers.edu id <154141-19607>; Mon, 25 Jan 1999 01:44:11 -0500
Received: from ripspost.aist.go.jp ([150.29.9.2]:50933 "EHLO ripspost.aist.go.jp" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <154163-19607>; Mon, 25 Jan 1999 01:43:58 -0500
Date: Mon, 25 Jan 1999 15:50:32 +0900 (JST)
From: Tom Holroyd <tomh@taz.ccs.fau.edu>
To: Alan Mimms <alan@packetengines.COM>
Cc: Charles Cazabon <charlesc-linux@qcc.sk.ca>, Linux Kernel <linux-kernel@vger.rutgers.edu>
Subject: Re: Random number generator for skiplists
In-Reply-To: <36A926F1.8C8FCB2F@packetengines.com>
Message-ID: <Pine.LNX.3.96.990125153818.5913C-100000@bhalpha1.nibh.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

Might I also suggest the Mersenne Twister (especially the recode by Shawn
Cokus) which is divide and mod free, short, low-memory, 623-dimensionally
equidistributed with a period of 2^19937 - 1, and fast.  It even has a
cool name.  :-) 

http://www.math.keio.ac.jp/~matumoto/emt.html

Dr. Tom Holroyd
I would dance and be merry,
Life would be a ding-a-derry,
If I only had a brain.
	-- The Scarecrow


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
