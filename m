Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263197AbTEFNGO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTEFNGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:06:14 -0400
Received: from [203.94.130.164] ([203.94.130.164]:62672 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id S263197AbTEFNGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:06:12 -0400
Date: Tue, 6 May 2003 22:58:01 +1000 (EST)
From: Brett <generica@email.com>
X-X-Sender: brett@bad-sports.com
To: Wichert Akkerman <wichert@wiggy.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 just doesn't boot (neither does anything > .67)
In-Reply-To: <20030506125726.GH20419@wiggy.net>
Message-ID: <Pine.LNX.4.44.0305062256370.2201-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Wichert Akkerman wrote:

> Previously Brett wrote:
> > linuxfromscratch system
> > unless they fix the source compilation problem i reported
> > <http://savannah.gnu.org/bugs/?func=detailbug&bug_id=3343&group_id=68>
> > then i can't install it
> 
> You can always install manually. 
> 

pardon ?
what do you mean by that

> > and anyway, can you provide any backup that this will fix it ?? what 
> > changed between 2.5.66 and 2.5.67 to stop grub loading the kernel ? why 
> > hasn't anyone else reported this ???
> 
> I couldn't boot 2.5 at all until I upgraded an ancient grub. Having
> a recent bootloader is never a bad thing though, and 0.92 is pretty
> old.
> 

I agree, but like i said
it fails to compile
the developers have not responded to my bug report
the cvs copy i checked out still has the same problem

i fail to see what more i can do

	/ Brett

