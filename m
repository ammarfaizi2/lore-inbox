Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272865AbRIPVuH>; Sun, 16 Sep 2001 17:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272857AbRIPVtq>; Sun, 16 Sep 2001 17:49:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38407 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272851AbRIPVte>; Sun, 16 Sep 2001 17:49:34 -0400
Date: Sun, 16 Sep 2001 14:48:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, <arjanv@redhat.com>,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] block highmem zero bounce v14
In-Reply-To: <20010916234307.A12270@suse.de>
Message-ID: <Pine.LNX.4.33.0109161447390.29507-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 16 Sep 2001, Jens Axboe wrote:
>
> It's against 2.4.10-pre9 and can be found right here:
>
> *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.10-pre9/block-highmem-all-14

Jens, what's your feeling about the stability of these things, especially
wrt weird drivers?

Ie do you think this is really a 2.4.x thing, or early 2.5.x?

		Linus

