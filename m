Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315529AbSEZByD>; Sat, 25 May 2002 21:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315530AbSEZByC>; Sat, 25 May 2002 21:54:02 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:48634 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315529AbSEZByB>; Sat, 25 May 2002 21:54:01 -0400
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Robert Schwebel <robert@schwebel.de>, linux-kernel@vger.kernel.org
In-Reply-To: <E17BiBY-0003nt-00@starship>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 May 2002 03:51:15 +0100
Message-Id: <1022381475.11811.72.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-05-25 at 21:30, Daniel Phillips wrote:
> A short time ago I made my living by programming large factory machines that
> can kill people in an instant.  I would have loved to use Linux, but it was
> not ready at the time.  As long as core developers continue to ignore the
> need for realtime capability in the kernel itself - as opposed to waving hands

This has nothing to do with real time. The capacity of computer science
to formally validate a system (and if it can kill people it should be
formally proven in something like Z) is not sufficient for a system so
complex. Such a device needs a tiny verifiable kernel core.

