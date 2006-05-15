Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWEOQc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWEOQc0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 12:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbWEOQc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 12:32:26 -0400
Received: from ns.suse.de ([195.135.220.2]:4782 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932432AbWEOQcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 12:32:25 -0400
Date: Mon, 15 May 2006 09:30:18 -0700
From: Greg KH <greg@kroah.com>
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Cc: Adrian Bunk <bunk@stusta.de>, Ingo Oeser <ioe-lkml@rameria.de>,
       Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.16
Message-ID: <20060515163018.GB16409@kroah.com>
References: <20060511022547.GE25010@moss.sous-sol.org> <296295514.20060511123419@dns.toxicfilms.tv> <20060511173312.GI25010@moss.sous-sol.org> <200605131735.20062.ioe-lkml@rameria.de> <20060513155610.GB6931@stusta.de> <7c3341450605131029l194174f3v7339dce0e234b555@mail.gmail.com> <20060514035937.GA6498@kroah.com> <9510556356.20060514094639@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9510556356.20060514094639@dns.toxicfilms.tv>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2006 at 09:46:39AM +0200, Maciej Soltysiak wrote:
> Hello Greg,
> 
> Sunday, May 14, 2006, 5:59:37 AM, you wrote:
> > To be fair, the extra work of writing out a detailed exploit, complete
> > with example code, for every security update, would just take way too
> > long.
> Well, I think what we meant is just a one-liner hint from a wise developer
> suggesting some action, meaning something like: "This one I recommend to all"
> or "Use this if you use SCTP" or "X can do nasty things, you should upgrade
> if you are using it". If the patch title is "Fix a buffer overflow in foo"
> everybody knows what to do, but when it says "Fix foo so that baz stays barred"
> an additional hint would be nice, because it's ambiguous for someone
> just tracking stable releases and not being knowledgible enough to decide
> whether baz is a function or system call that they are using.
> 
> I was not suggesting full detailed reports, I know the developers have better
> things to do, just some hints :-)

If you read the full patch description, or the full changelog, you will
almost always get those hints.  The changelog is always availble on
kernel.org next to the kernel patch/source tree.

thanks,

greg k-h
