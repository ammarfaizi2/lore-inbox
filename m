Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317845AbSGVWUb>; Mon, 22 Jul 2002 18:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317846AbSGVWUb>; Mon, 22 Jul 2002 18:20:31 -0400
Received: from air-2.osdl.org ([65.172.181.6]:61110 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S317845AbSGVWUa>;
	Mon, 22 Jul 2002 18:20:30 -0400
Subject: Re: Alright, I give up.  What does the "i" in "inode" stand for?
From: Joe DiMartino <joe@osdl.org>
To: Rob Landley <landley@trommello.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200207190432.g6J4WD2366706@pimout5-int.prodigy.net>
References: <200207190432.g6J4WD2366706@pimout5-int.prodigy.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Jul 2002 15:23:12 -0700
Message-Id: <1027376592.15134.52.camel@joe2.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 15:33, Rob Landley wrote:
> I've been sitting on this question for years, hoping I'd come across the 
> answer, and I STILL don't know what the "i" is short for.  Somebody here has 
> got to know this. :)
> 

Two plausible definitions:

The Magic Garden Explained calls them "information nodes".

A really old (1983) Byte Book called Introducing the Unix System has
this to say:

	A file in the UNIX system is described by an object called an
	"i-node".  We think that the name means "interior node", since
	the UNIX file-system is (in principle at least) a directed
	graph.  For every file there is a single i-node that describes
	that file, and contains pointers to blocks that comprise that
	file.


So, what do you _want_ it to mean? :-)

- Joe DiMartino





