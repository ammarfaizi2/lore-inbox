Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263399AbTDCNua>; Thu, 3 Apr 2003 08:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263400AbTDCNua>; Thu, 3 Apr 2003 08:50:30 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:17673 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263399AbTDCNu3>; Thu, 3 Apr 2003 08:50:29 -0500
Date: Thu, 3 Apr 2003 16:01:47 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Andries Brouwer <aebr@win.tue.nl>
cc: Badari Pulavarty <pbadari@us.ibm.com>, <Joel.Becker@oracle.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <20030403133725.GA14027@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0304031548090.12110-100000@serv>
References: <200303311541.50200.pbadari@us.ibm.com>
 <Pine.LNX.4.44.0304021413210.12110-100000@serv> <200304020931.38671.pbadari@us.ibm.com>
 <Pine.LNX.4.44.0304031256550.5042-100000@serv> <20030403133725.GA14027@win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 3 Apr 2003, Andries Brouwer wrote:

> > I am really interested why nobody wants to do now
> > that small deciding step to use dynamic dev_t numbers.
> 
> Because we first want to have the numbers before using them?

Yes, I know this mantra now and that's not the problem (or will be fixed 
shortly).
This still doesn't answer what will come next. You must have _some_ idea, 
otherwise you wouldn't add a new interface, remove other infrastructure 
and provide a patch which modifies MKDEV & co. All of this only leads us 
away from the goal of dynamic device numbers. Why?

bye, Roman

