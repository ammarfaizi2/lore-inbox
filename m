Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265570AbTBPFZs>; Sun, 16 Feb 2003 00:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265863AbTBPFZs>; Sun, 16 Feb 2003 00:25:48 -0500
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:38084
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S265570AbTBPFZr>; Sun, 16 Feb 2003 00:25:47 -0500
Date: Sun, 16 Feb 2003 00:35:31 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: David Lang <david.lang@digitalinsight.com>
cc: Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: openbkweb-0.0
In-Reply-To: <Pine.LNX.4.44.0302152104500.6594-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.44.0302160027390.17241-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2003, David Lang wrote:

> On the basis that it's easier to provide everything rather then to
> convince people to change tools :-) here is what I'm thinking of (all of
> these obviously read-only)
> 
> CVS
> rsync
> FTP
> HTTP
> 
> is there anything else people want?

If you can manage to have a CVS repository that is always updated to the 
minute with full history info etc. then this should be suficient to satisfy 
all needs.  Public CVS repositories are common enough so people should know 
how to use them already.

The best would be a few of those scattered around the world so things do
scale.  It shouldn't be that much bandwidth for bkbits.net to update them
all automatically for example.


Nicolas

