Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271581AbRHPQAW>; Thu, 16 Aug 2001 12:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271579AbRHPQAD>; Thu, 16 Aug 2001 12:00:03 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25092 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271578AbRHPP7z>; Thu, 16 Aug 2001 11:59:55 -0400
Subject: Re: Via chipset
To: bmartin@ayrix.net (Bob Martin)
Date: Thu, 16 Aug 2001 17:02:41 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Bob Martin" at Aug 16, 2001 10:35:41 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15XPbV-0005Td-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> figured what in xscreensaver is doing this, don't know if it might be kernel
> related or not, probably not. I suspect xscreensaver is triggering something in
> the xserver that is not normally getting hit in normal use.

Thats actually quite possible. In paticular it uses arc's which basically no
other X app ever does. Report that info to either XFree or nvidia (depending
on whose X server)

Alan
