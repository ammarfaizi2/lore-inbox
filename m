Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280430AbRKNKoy>; Wed, 14 Nov 2001 05:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280434AbRKNKoo>; Wed, 14 Nov 2001 05:44:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:35857 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280430AbRKNKof>; Wed, 14 Nov 2001 05:44:35 -0500
Subject: Re: What Athlon chipset is most stable in Linux?
To: davem@redhat.com (David S. Miller)
Date: Wed, 14 Nov 2001 10:51:49 +0000 (GMT)
Cc: goemon@anime.net, nitrax@giron.wox.org, linux-kernel@vger.kernel.org
In-Reply-To: <20011113.182956.75780493.davem@redhat.com> from "David S. Miller" at Nov 13, 2001 06:29:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163xe2-0004IM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    From: Dan Hollis <goemon@anime.net>
>    Date: Tue, 13 Nov 2001 13:19:07 -0800 (PST)
>    
>    AMD761 ... is what you want.
> 
> Unless you actually plan on actually using the AGP slot without
> crashes/hangs.

Only if your card hits the AMD errata, and that specifically claims the
card is the problem. It mostly appears to afflict nvidia users so its not
a problem ;)
