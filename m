Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318019AbSHHVzc>; Thu, 8 Aug 2002 17:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318024AbSHHVzc>; Thu, 8 Aug 2002 17:55:32 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:61708 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318019AbSHHVzb>; Thu, 8 Aug 2002 17:55:31 -0400
Date: Thu, 8 Aug 2002 23:58:31 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Luca Barbieri <ldb@ldb.ods.org>
cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5] asm-generic/atomic.h and changes to arm, parisc,
 mips, m68k, sh, cris to use it
In-Reply-To: <1028842995.1669.70.camel@ldb>
Message-ID: <Pine.LNX.4.44.0208082357170.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8 Aug 2002, Luca Barbieri wrote:

> On UP, it disables interrupts around atomic ops with the exception of
> non-testing ops on m68k.

Why did you change m68k? It was fine before.

bye, Roman

