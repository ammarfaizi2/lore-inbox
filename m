Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287276AbSAPTLg>; Wed, 16 Jan 2002 14:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287279AbSAPTL0>; Wed, 16 Jan 2002 14:11:26 -0500
Received: from smtp6.mindspring.com ([207.69.200.110]:7428 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S287276AbSAPTLP>; Wed, 16 Jan 2002 14:11:15 -0500
From: "Chris Swiedler" <ceswiedler@mindspring.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: hex addresses in setup.S
Date: Wed, 16 Jan 2002 14:13:01 -0500
Message-ID: <BJEJJDPJOCEPDBLPFDKJCEACCCAA.ceswiedler@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why does setup.S define the default system load address as 0x1000, and the
comment on the line explain this to be 0x10000(and gives the decimal
translation of 65536, so it's not a typo)? This seems to be true for several
addresss (0x9000 = 0x90000, etc). I'm sure there's something simple I'm
missing...what is it?

TIA,
chris

