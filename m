Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264737AbRFSTUu>; Tue, 19 Jun 2001 15:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264743AbRFSTUi>; Tue, 19 Jun 2001 15:20:38 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:38854 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264737AbRFSTU3>;
	Tue, 19 Jun 2001 15:20:29 -0400
Date: Tue, 19 Jun 2001 15:20:25 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 corruption (again)
In-Reply-To: <200106191352.f5JDqXO12351@work.bitmover.com>
Message-ID: <Pine.GSO.4.21.0106191519380.22741-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Jun 2001, Larry McVoy wrote:

> OK, my corruption is back and this time I'm saving the data.  Al, send some 
> email when you are around, we can talk about access to the data.  I'm tarring

Doing that.

> up both good & bad right now.  I've looked at a few files and they look
> "shifted".
> 
> 	extra junk
> 	original file less sizeof(extra junk) bytes
> 
> The machine has been up 6 days since the last corruption happened and the
> process which detected the corruption ran successfully every night as well
> as about 4 times by hand after my last corroption report.  

Lovely. Are these files longer than 4Kb, BTW?

