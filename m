Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262568AbRE3CZk>; Tue, 29 May 2001 22:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262579AbRE3CZa>; Tue, 29 May 2001 22:25:30 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:25071 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262568AbRE3CZS>;
	Tue, 29 May 2001 22:25:18 -0400
Date: Tue, 29 May 2001 19:25:16 -0700
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: jt@hpl.hp.com, Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, tori@unhappy.mine.nu,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net #9
Message-ID: <20010529192516.A14915@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <200105300048.CAA04583@green.mif.pg.gda.pl> <20010529180420.A14639@bougret.hpl.hp.com> <3B14493E.63F861E7@mandrakesoft.com> <20010529182506.A14727@bougret.hpl.hp.com> <3B145127.5B173DFF@mandrakesoft.com> <20010529190152.A14806@bougret.hpl.hp.com> <3B14572E.47218B5@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B14572E.47218B5@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, May 29, 2001 at 10:13:02PM -0400
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2001 at 10:13:02PM -0400, Jeff Garzik wrote:
> *shrug*  Well, if you want to go against the kernel standard that's fine
> with me.  I won't put Andrzej's changes to your drivers upstream.  You
> are going to continually see patches to clean that up, though, because
> it makes the end user's kernel smaller.  Please consider noting this
> special case in a comment in each of your drivers "do not clean up
> static initializers" or similar.
> 
> It's really a pain in the ass to remember special cases like this, so
> please reconsider.  Being not-like-the-others is detrimental to the long
> term maintainability of the overall kernel.
> 
> Regards,
> 
> 	Jeff

	I agree with you on the special case. I don't like it
either. Anyway, most patch to my drivers are applied wether I like it
or not, so I guess that I should be happy that I was notified and I
should sut up my big mouth because it won't make a difference.
	If I reject the patch now, I will be applied behind my
back. Been there, done that.
	In other words : yes, please apply the patch.

	Jean
