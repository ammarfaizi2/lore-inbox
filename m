Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274395AbRITJy0>; Thu, 20 Sep 2001 05:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274396AbRITJyP>; Thu, 20 Sep 2001 05:54:15 -0400
Received: from skiathos.physics.auth.gr ([155.207.123.3]:10936 "EHLO
	skiathos.physics.auth.gr") by vger.kernel.org with ESMTP
	id <S274395AbRITJyF>; Thu, 20 Sep 2001 05:54:05 -0400
Date: Thu, 20 Sep 2001 12:54:21 +0300 (EET DST)
From: Liakakis Kostas <kostas@skiathos.physics.auth.gr>
To: Nicholas Knight <tegeran@home.com>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Re[2]: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <01091917190600.00628@c779218-a>
Message-ID: <Pine.GSO.4.21.0109201253210.4798-100000@skiathos.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, Nicholas Knight wrote:

> Is there an way someone could find out what Windows, possibly with VIA's 
> 4-in-1 drivers, do with this bit? And for that matter, what the test 
> program that tests it regardless of kernel optimizations does in Windows, 
> if it can be ported?

Win2k, Via4132. They leave it alone ax 0x89. Asus A7V133, Athlon TB 1.4-C

-K.


