Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964969AbWDGVeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWDGVeb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 17:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWDGVeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 17:34:31 -0400
Received: from xenotime.net ([66.160.160.81]:33422 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964969AbWDGVea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 17:34:30 -0400
Date: Fri, 7 Apr 2006 14:36:48 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/POC] multiple CONFIG y/m/n
Message-Id: <20060407143648.137a134d.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.64.0604072315530.32445@scrub.home>
References: <20060406224134.0430e827.rdunlap@xenotime.net>
	<20060407184400.GA9097@mars.ravnborg.org>
	<Pine.LNX.4.64.0604072315530.32445@scrub.home>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2006 23:24:44 +0200 (CEST) Roman Zippel wrote:

> Hi,
> 
> On Fri, 7 Apr 2006, Sam Ravnborg wrote:
> 
> > > In doing lots of kernel build testing, I often want to enable all options
> > > in a sub-menu and their sub-sub-menus.  Sound is one of the worst^W longest
> > > of these, so I chose a shorter (easier) one to practice on:  parport.
> > If there is a general need for this we shal enhance kconfig with this.
> > We shall not clutter the Kconfig files with this.
> 
> I agree.
> >From a general perspective I still like to add some basic command line 
> tool, which can be used for queries or simple manipulations. Here it also 
> would be less a problem to add experimental or distribution specific 
> functionality instead of overloading conf.c.
> At some point I even had script bindings (via swig), so one could do even 
> weirder stuff.

Yep, no problem with Sam's or your reply.  Thanks for looking.

---
~Randy
