Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267524AbTALU3v>; Sun, 12 Jan 2003 15:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267505AbTALUX3>; Sun, 12 Jan 2003 15:23:29 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:32779
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267503AbTALUXC>; Sun, 12 Jan 2003 15:23:02 -0500
Subject: Re: any chance of 2.6.0-test*?
From: Robert Love <rml@tech9.net>
To: robw@optonline.net
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
	 <1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
Content-Type: text/plain
Organization: 
Message-Id: <1042403499.834.91.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 12 Jan 2003 15:31:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 14:34, Rob Wilkens wrote:

> I'm REALLY opposed to the use of the word "goto" in any code where
> it's not needed.  OF course, I'm a linux kernel newbie, so I'm in
> no position to comment

We use goto's extensively in the kernel.  They generate fast, tight
code.

There is nothing wrong with being a newbie, but there is something wrong
with voicing ignorance.  "Learn first, form opinions later".

When you start posting more than most of the developers here, combined,
and none of your posts are contributive kernel code, there is a problem.

	Robert Love

