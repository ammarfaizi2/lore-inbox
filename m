Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbTEAAtk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 20:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbTEAAtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 20:49:40 -0400
Received: from smtp-out.comcast.net ([24.153.64.109]:51737 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S262623AbTEAAti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 20:49:38 -0400
Date: Wed, 30 Apr 2003 21:00:30 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: Kernel source tree splitting
In-reply-to: <20030501005224.GA8676@work.bitmover.com>
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <200304302100300700.0157A42C@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <200304301946130000.01139CC8@smtp.comcast.net>
 <20030430172102.69e13ce9.rddunlap@osdl.org>
 <20030501005224.GA8676@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



*********** REPLY SEPARATOR  ***********

On 4/30/2003 at 5:52 PM Larry McVoy wrote:

>It would be *really* cool if the Makefile dependencies actually worked.
>It's a very little known fact but if you are in an RCS or SCCS (and BK
>looks like SCCS to make) source tree and the files are not checked out,
>you can just say
>
>	make
>
>and make will look for a makefile, if there isn't one but there is a
>SCCS/s.[Mm]akefile it will check it out, look at the dependencies and start
>checking those out and keep doing it to satisfy the target.
>
>It's a really pleasant way to work, the "make clobber" target "cleans"
>all the source so it isn't checked out, the directory is nice and empty.
>This makes it easy to see stuff you still need to check in or think about.
>It's definitely an old timer way of working, I'm pretty sure that the
>original Unix was done this way but just because it is old doesn't mean
>it is bad.  Opinions differ on that :)
>
>Here's a make in a cleaned BK source tree:
[cut]

....

Larry... what the heck are you talking about?  No really you lost me
:)

Are you talking about hitting a button and flushing all the code but
what's new, or about actually making different tarballs cause the
source tree to auto-adapt to what's in it?

What is RCS/SCCS

--Bluefox Icy

