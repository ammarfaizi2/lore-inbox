Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265242AbRF0Uvu>; Wed, 27 Jun 2001 16:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbRF0Uvk>; Wed, 27 Jun 2001 16:51:40 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:22536 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265242AbRF0Uv3>; Wed, 27 Jun 2001 16:51:29 -0400
Date: Wed, 27 Jun 2001 13:50:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: <alan@lxorguk.ukuu.org.uk>, <jffs-dev@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <19708.993559928@redhat.com>
Message-ID: <Pine.LNX.4.33.0106271348420.24832-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 26 Jun 2001, David Woodhouse wrote:
>
> Linus, Alan - Please apply the following self-explanatory patch.

How about we drop the "printk" altogether, and make it all a comment?

I find printk's with copyright notices quite disturbing. You will notice
that I don't have any myself. I think the whole thing is very tasteless,
and the "polite reminder" is just complete crap.

You're allowed to remove offensive printk's, that's not a copyright notice
in Linux, that's just a big ugly bother. The copyright notice is that big
comment at the top of the file.

		Linus

