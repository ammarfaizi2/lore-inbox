Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266076AbRF1R6p>; Thu, 28 Jun 2001 13:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266072AbRF1R6f>; Thu, 28 Jun 2001 13:58:35 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:32274 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266071AbRF1R6U>; Thu, 28 Jun 2001 13:58:20 -0400
Date: Thu, 28 Jun 2001 10:56:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <chuckw@altaserv.net>,
        Vipin Malik <vipin.malik@daniel.com>,
        Aaron Lehmann <aaronl@vitelus.com>, <jffs-dev@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Cosmetic JFFS patch. 
In-Reply-To: <7953.993749740@redhat.com>
Message-ID: <Pine.LNX.4.33.0106281055410.15199-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Jun 2001, David Woodhouse wrote:
>
> I agree the messages can be ugly. But they don't do any harm either, and
> sometimes they're useful.

I consider them harmful when I start getting annoying patches that start
adding more and more of them.

Which is how this whole thread started.

My solution was to just move it into a comment, at which point I don't
mind adding more copyright notices, because I know it cannot annoy a real
user.

And "real users" are what matters, after all.

		Linus

