Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279228AbRKNQzE>; Wed, 14 Nov 2001 11:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280697AbRKNQyy>; Wed, 14 Nov 2001 11:54:54 -0500
Received: from cc797718-a.jrsycty1.nj.home.com ([24.253.208.156]:23051 "EHLO
	buggy.badula.org") by vger.kernel.org with ESMTP id <S279228AbRKNQyl>;
	Wed, 14 Nov 2001 11:54:41 -0500
Date: Wed, 14 Nov 2001 11:54:35 -0500
Message-Id: <200111141654.fAEGsZw21612@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What Athlon chipset is most stable in Linux?
In-Reply-To: <20011113.191607.00304518.davem@redhat.com>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.14 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2001 19:16:07 -0800 (PST), David S. Miller <davem@redhat.com> wrote:
>   From: Dan Hollis <goemon@anime.net>
>   Date: Tue, 13 Nov 2001 19:11:56 -0800 (PST)
> 
>   BTW this bug apparently doesnt affect AMD760MP as I am able to use
>   geforce2 with quake and unreal tournament for hours straight without any
>   problems.
> 
> I'm rather sure the AMD761 problems are motherboard vendor
> independant, because I have 2 systems so far, using totally different
> AMD761 based motherboards, which both hang pretty reliably with AGP.

As far as I know, the 760MP chipset uses a 762 North Bridge, not a 761. 
That might explain why the 760MP is stable and the 760 is not.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
