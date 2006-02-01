Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbWBAEUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWBAEUF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 23:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030242AbWBAEUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 23:20:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:911 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030227AbWBAEUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 23:20:03 -0500
Date: Tue, 31 Jan 2006 20:19:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>, Linas Vepstas <linas@austin.ibm.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] PCI patches for 2.6.16-rc1
In-Reply-To: <20060201040336.GA26107@suse.de>
Message-ID: <Pine.LNX.4.64.0601312016370.7301@g5.osdl.org>
References: <20060201020437.GA20719@kroah.com> <Pine.LNX.4.64.0601311813400.7301@g5.osdl.org>
 <20060201040336.GA26107@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Jan 2006, Greg KH wrote:

> On Tue, Jan 31, 2006 at 06:16:43PM -0800, Linus Torvalds wrote:
> > 
> > Linas - could you _please_ fix your email setup, of if your email setup is 
> > good, could whoever added the bogus "From: " line to the email please NOT 
> > DO THAT HORRIBLE THING?
> 
> At least he put a valid email address in there, it used to just bounce
> to a non-existant domain :(

Btw, Linas - even if you can't fix your broken mail setup, what you _can_ 
do is to always make sure that the patches you send out have

	From: Linas Vepstas <linas@austin.ibm.com>

as the first line of the body - then the tools will figure out to use that 
instead of the broken mail headers. Ok?

(This is true in general - so anybody else who knows that they send out 
emails from a strange address that they'd rather have show up as their 
"real" email address instead in the changelogs can do the same).

		Linus

PS. It's _damn_ hard to type "Linas". Every time, that "a" just becomes an 
"u" for me. My fingers obviously have certain things hard-coded ;)
