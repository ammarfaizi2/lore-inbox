Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310207AbSB1XvL>; Thu, 28 Feb 2002 18:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310169AbSB1XtP>; Thu, 28 Feb 2002 18:49:15 -0500
Received: from perth.fpcc.net ([207.174.142.141]:30750 "EHLO perth.fpcc.net")
	by vger.kernel.org with ESMTP id <S310166AbSB1XoJ>;
	Thu, 28 Feb 2002 18:44:09 -0500
Message-Id: <200202282343.QAA15734@perth.fpcc.net>
Content-Type: text/plain; charset=US-ASCII
From: Peter Hutnick <peter@fpcc.net>
To: John Jasen <jjasen1@umbc.edu>
Subject: Re: wvlan_cs in limbo?
Date: Thu, 28 Feb 2002 14:41:39 -0700
X-Mailer: KMail [version 1.3.1]
Cc: Jason Cook <jasonc@reinit.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SGI.4.31L.02.0202281834390.5604431-100000@irix2.gl.umbc.edu>
In-Reply-To: <Pine.SGI.4.31L.02.0202281834390.5604431-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 February 2002 04:35 pm, John Jasen wrote:
> On Thu, 28 Feb 2002, Peter Hutnick wrote:
> > The wvlan_cs driver is in the current pcmcia-cs package, but isn't built
> > with "make all."  I'm "just an end user" so I am not really cut out for
> > figuring out how to build it manually.
>
> pcmcia-cs does not build modules if, by fading memory, the kernel has
> pcmcia and cardbus support enabled.

RIght.  Turned it off.  It built a bunch of /other/ modules.

Thanks, though.

-Peter
