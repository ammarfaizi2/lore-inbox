Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316106AbSE3Bka>; Wed, 29 May 2002 21:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316239AbSE3Bk3>; Wed, 29 May 2002 21:40:29 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:51706 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S316106AbSE3BjC>; Wed, 29 May 2002 21:39:02 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15605.33447.950045.532904@wombat.chubb.wattle.id.au>
Date: Thu, 30 May 2002 11:38:47 +1000
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Linux 2.5.19
In-Reply-To: <805239813@toto.iv>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Tom" == Tom Rini <trini@kernel.crashing.org> writes:

Tom> Hello.  The following fixes compilation with CONFIG_BLK_DEV_RAM=y
Tom> I assume that Rusty intended to use a test for CONFIG_BLK_DEV_RAM
Tom> and not BLOCK_DEV_RAM.


That was me, not Rusty --- and yes, your fix is correct.

Thanks,
	PeterC
--
You are lost in a maze of bitkeeper repositories, all slightly different.
