Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbTEGAas (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 20:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbTEGAad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 20:30:33 -0400
Received: from [203.94.130.164] ([203.94.130.164]:41681 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id S262232AbTEGA2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 20:28:52 -0400
Date: Wed, 7 May 2003 10:20:38 +1000 (EST)
From: Brett <generica@email.com>
X-X-Sender: brett@bad-sports.com
To: Daniel Pittman <daniel@rimspace.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 just doesn't boot (neither does anything > .67)
In-Reply-To: <87u1c8w6j9.fsf@enki.rimspace.net>
Message-ID: <Pine.LNX.4.44.0305071019580.4403-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 May 2003, Daniel Pittman wrote:

> On Tue, 6 May 2003, Wichert Akkerman wrote:
> > Previously Brett wrote:
> 
> [...]
> 
> >> and anyway, can you provide any backup that this will fix it ?? what
> >> changed between 2.5.66 and 2.5.67 to stop grub loading the kernel ? 
> >> why hasn't anyone else reported this ???
> > 
> > I couldn't boot 2.5 at all until I upgraded an ancient grub. Having
> > a recent bootloader is never a bad thing though, and 0.92 is pretty
> > old.
> 
> 0.92 is successfully booting 2.5.6[89] here, and 0.93 (Debian or
> upstream) fails to boot on most of my machines here.
> 
> YMMV, of course, but 0.92 works for me.
> 

yea, i was very dubious that grub was the problem
as it is, i've upgraded to 0.93, and the problem remains

thanks,

	/ Brett

