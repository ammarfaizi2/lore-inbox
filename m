Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263837AbSLFRAg>; Fri, 6 Dec 2002 12:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbSLFRAg>; Fri, 6 Dec 2002 12:00:36 -0500
Received: from rakis.net ([216.235.252.212]:64909 "EHLO egg.rakis.net")
	by vger.kernel.org with ESMTP id <S263837AbSLFRAf>;
	Fri, 6 Dec 2002 12:00:35 -0500
Date: Fri, 6 Dec 2002 12:08:12 -0500 (EST)
From: Greg Boyce <gboyce@rakis.net>
X-X-Sender: gboyce@egg
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dazed and Confused
In-Reply-To: <Pine.LNX.4.42.0212061133330.7770-100000@egg>
Message-ID: <Pine.LNX.4.42.0212061202230.7770-100000@egg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Dec 2002, Greg Boyce wrote:

> On 6 Dec 2002, Alan Cox wrote:
> > Take a sample set of machines which have been crashing and run memtest86
> > on a couple. That should tell you if it is RAM. From a sample you can
> > then figure out how to handle the rest (things that come to mind if
> > memtest86 fails on the test machines include replacing the ram in a few
> > more then taking the old ram back to test)
>
> I'll mention it to the people who handle the replacement of hardware, but
> from the sounds of this and Dick's e-mail, it's most likely hardware of
> some sort or possibly overheating.  They can decide if they want to try to
> figure out which component is causing the problem, or if they'd prefer to
> just replace the faulty machines completely and worry about tracking the
> component later.  We have plenty of spares in the warehouse.

Actually, this does leave one question still:  How serious is the problem?
How much would you trust a machine reporting these errors?  Most of the
machines are just performing DNS and web service (although with a pretty
high load).  The processes on the machine are are cpu and memory
intensive, but there is no critical data stored on most of the machines.

Are the machines likely to give us problems with crashing and data
corruption, or would it be safe to ignore the problem unless we started
noticing odd behavior?

Greg

