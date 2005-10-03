Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932613AbVJCS7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932613AbVJCS7Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbVJCS7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:59:25 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:51204 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932613AbVJCS7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:59:25 -0400
Date: Mon, 3 Oct 2005 20:59:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Haninger <ahaning@gmail.com>
Cc: lokum spand <lokumsspand@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: A possible idea for Linux: Save running programs to disk
Message-ID: <20051003185923.GG3652@stusta.de>
References: <BAY105-F35A25DA28443029610815DA48E0@phx.gbl> <105c793f0510012236j16033efbh400f6f2a8495d03e@mail.gmail.com> <20051003174122.GD3652@stusta.de> <105c793f0510031152v76225bc7r83e5e2170f3434d5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <105c793f0510031152v76225bc7r83e5e2170f3434d5@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 02:52:52PM -0400, Andrew Haninger wrote:
> On 10/3/05, Adrian Bunk <bunk@stusta.de> wrote:
> > Where are hardware issues with suspend to disk?
> >
> Actually, very few currently [AFAIK, on my hardware]. However, at
> least in the past, my r200 card wasn't useable after resume from
> suspend without patches to XFree86. I know people had trouble with the
> fglrx drivers not supporting suspend-to-disk. [I believe current r300
> drivers work fine, but I do not have personal confirmation.] I have a
> machine that used to have issues because I was using a keyboard and no
> mouse. When I resumed, the keyboard didn't work. If I had a mouse
> plugged in, suspend/resume worked fine. Here's a link to my mail to
> LKML about this issue:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112139506118959&w=2
> 
> As new hardware is introduced and drivers have to be written or
> reverse-engineered and kinks worked out, bugs like these will crop up
> again and again. [That is, unless manufacturers become more open about
> their hardware. From my perspective, they are becoming more closed.
> ATI, for example.]
>...

These are all software problems, not hardware problems.
 
> Neat.
> 
> -Andy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

