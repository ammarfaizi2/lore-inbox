Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129884AbQK2B7G>; Tue, 28 Nov 2000 20:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129742AbQK2B65>; Tue, 28 Nov 2000 20:58:57 -0500
Received: from anime.net ([63.172.78.150]:3089 "EHLO anime.net")
        by vger.kernel.org with ESMTP id <S129884AbQK2B6m>;
        Tue, 28 Nov 2000 20:58:42 -0500
Date: Tue, 28 Nov 2000 17:29:04 -0800 (PST)
From: Dan Hollis <goemon@anime.net>
To: "J . A . Magallon" <jamagallon@able.es>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: XFree 4.0.1/NVIDIA 0.9-5/2.4.0-testX/11 woes [solved]
In-Reply-To: <20001129021025.A768@werewolf.able.es>
Message-ID: <Pine.LNX.4.30.0011281722220.27692-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, J . A . Magallon wrote:
> On Wed, 29 Nov 2000 01:39:56 Dan Hollis wrote:
> > Dont forget the nvidia driver is completely SMP broken. As in, trash your
> > filesystems broken.
> Not so broken. I use it under SMP 2.2.18-pre23 and works fine.

Try unreal tournament. Locks up hard during the intro animation. It's been
listed for months in the nvidia FAQ as a known bug (#6.5.7) with no fix.

http://x54.deja.com/getdoc.xp?AN=687585074&CONTEXT=975461056.438435863&hitnum=2
http://x54.deja.com/getdoc.xp?AN=690445861&CONTEXT=975461056.438435863&hitnum=3

-Dan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
