Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266369AbSKOP51>; Fri, 15 Nov 2002 10:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266387AbSKOP50>; Fri, 15 Nov 2002 10:57:26 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:39431 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266369AbSKOP5Z>;
	Fri, 15 Nov 2002 10:57:25 -0500
Date: Fri, 15 Nov 2002 17:03:08 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Nicolas Pitre <nico@cam.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Bill Davidsen <davidsen@tmr.com>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: make distclean and make dep??
Message-ID: <20021115160308.GB1320@mars.ravnborg.org>
Mail-Followup-To: Nicolas Pitre <nico@cam.org>,
	Sam Ravnborg <sam@ravnborg.org>, Bill Davidsen <davidsen@tmr.com>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Andreas Steinmetz <ast@domdv.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021115145312.GA1320@mars.ravnborg.org> <Pine.LNX.4.44.0211151059370.1073-100000@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211151059370.1073-100000@xanadu.home>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 11:01:05AM -0500, Nicolas Pitre wrote:
> On Fri, 15 Nov 2002, Sam Ravnborg wrote:
> 
> > On Thu, Nov 14, 2002 at 07:31:24PM -0500, Bill Davidsen wrote:
> > > > No need for that, when make clean deletes enough.
> > > 
> > > Unless you want to make a distribution, or see that a distribution made
> > > from your patched kernel would build.
> > Then let me repeat again:
> > distclean and mrproper is combined today. They do exactly the same.
> 
> In this case distclean should return in the target help text then.
It will.

	Sam
