Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266384AbSKOP4g>; Fri, 15 Nov 2002 10:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266386AbSKOP4f>; Fri, 15 Nov 2002 10:56:35 -0500
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:39563
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S266384AbSKOP4f>; Fri, 15 Nov 2002 10:56:35 -0500
Date: Fri, 15 Nov 2002 11:01:05 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: Bill Davidsen <davidsen@tmr.com>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: make distclean and make dep??
In-Reply-To: <20021115145312.GA1320@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0211151059370.1073-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2002, Sam Ravnborg wrote:

> On Thu, Nov 14, 2002 at 07:31:24PM -0500, Bill Davidsen wrote:
> > > No need for that, when make clean deletes enough.
> > 
> > Unless you want to make a distribution, or see that a distribution made
> > from your patched kernel would build.
> Then let me repeat again:
> distclean and mrproper is combined today. They do exactly the same.

In this case distclean should return in the target help text then.


Nicolas

