Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266544AbUBRBoi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 20:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUBRBoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 20:44:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:7843 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266544AbUBRBog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 20:44:36 -0500
Date: Tue, 17 Feb 2004 17:44:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Intel vs AMD x86-64
Message-ID: <Pine.LNX.4.58.0402171739020.2686@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, 
 now that Intel has finally come clean about their x86-64 implementation
(see

	http://www.intel.com/technology/64bitextensions/index.htm?iid=techtrends+spotlight_64bit

for full details), can somebody write up a list of differences? I know
there are people who have had access to the Intel docs for a while now,
and obviously Intel is too frigging proud to list the differences
explicitly.

>From what I can tell from a quick look, it looks like it is basically just
the 3DNow vs SSE3 thing, but I assume there are other details too.  Can
people who have been involved with this make a quick list for the rest of
us who only got to see the final details today?

(And I assume there's somebody with a few patches pending..)

	Thanks,
		Linus
