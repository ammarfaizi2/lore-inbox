Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263906AbRFSNwz>; Tue, 19 Jun 2001 09:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263928AbRFSNwq>; Tue, 19 Jun 2001 09:52:46 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:43280
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S263906AbRFSNwg>; Tue, 19 Jun 2001 09:52:36 -0400
From: Larry McVoy <lm@bitmover.com>
Date: Tue, 19 Jun 2001 06:52:33 -0700
Message-Id: <200106191352.f5JDqXO12351@work.bitmover.com>
To: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: 2.4.5 corruption (again)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, my corruption is back and this time I'm saving the data.  Al, send some 
email when you are around, we can talk about access to the data.  I'm tarring
up both good & bad right now.  I've looked at a few files and they look
"shifted".

	extra junk
	original file less sizeof(extra junk) bytes

The machine has been up 6 days since the last corruption happened and the
process which detected the corruption ran successfully every night as well
as about 4 times by hand after my last corroption report.  
