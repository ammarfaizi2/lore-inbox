Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288331AbSACVfP>; Thu, 3 Jan 2002 16:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288328AbSACVfG>; Thu, 3 Jan 2002 16:35:06 -0500
Received: from web14911.mail.yahoo.com ([216.136.225.249]:42502 "HELO
	web14911.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S288329AbSACVe4>; Thu, 3 Jan 2002 16:34:56 -0500
Message-ID: <20020103213455.34699.qmail@web14911.mail.yahoo.com>
Date: Thu, 3 Jan 2002 16:34:55 -0500 (EST)
From: Michael Zhu <mylinuxk@yahoo.ca>
Subject: The CURRENT macro
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In Alessandro Rubini's book Linux Device Driver(Second
Edition), Chatper 12, he said that "By accessing the
fields in the request structure, usually by way of
CURRENT" and "CURRENT is just a pointer into
blk_dev[MAJOR_NR].request_queue". I know CURRENT is
just a macro. Where can I find the definition of this
macro?
I just don't know how to get the struct request from
the request_queue(a request_queue_t struct). CURRENT
points to which field in the
blk_dev[MAJOR_NR].request_queue? Thank you very much.

Michael

______________________________________________________ 
Send your holiday cheer with http://greetings.yahoo.ca
