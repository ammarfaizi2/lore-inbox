Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265562AbSKDMpR>; Mon, 4 Nov 2002 07:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265632AbSKDMpR>; Mon, 4 Nov 2002 07:45:17 -0500
Received: from mailgw3a.lmco.com ([192.35.35.7]:5389 "EHLO mailgw3a.lmco.com")
	by vger.kernel.org with ESMTP id <S265562AbSKDMpQ>;
	Mon, 4 Nov 2002 07:45:16 -0500
Content-return: allowed
Date: Mon, 04 Nov 2002 07:51:38 -0500
From: "Reed, Timothy A" <timothy.a.reed@lmco.com>
Subject: idle=poll needed??
To: "Linux Kernel ML (E-mail)" <linux-kernel@vger.kernel.org>
Message-id: <9EFD49E2FB59D411AABA0008C7E675C00DCDFC48@emss04m10.ems.lmco.com>
MIME-version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	We currently have setup, Dual P4-Xeon 2.2G machines running 2.4.19,
with 2GB of RAM.
	Is there any performance reasons to keep the idle=poll in the append
line?  I have not seen any degraded performance with the option, but some of
our subs are having performance issues with it in.

TIA,
Timothy Reed
Software Engineer \ Systems Administrator
Lockheed Martin - NE & SS Syracuse
Email: timothy.a.reed@lmco.com

The Box Said "Requires Windows  95 or Better", so I installed Linux!

