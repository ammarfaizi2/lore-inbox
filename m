Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265636AbTFNHsG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 03:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265637AbTFNHsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 03:48:06 -0400
Received: from [64.35.99.205] ([64.35.99.205]:15627 "EHLO www.theshore.net")
	by vger.kernel.org with ESMTP id S265636AbTFNHsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 03:48:05 -0400
Message-ID: <000c01c3324b$872523c0$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
To: <linux-kernel@vger.kernel.org>
References: <20030614063539.GA508@bouh.unh.edu> <003a01c33247$da8df8b0$0201a8c0@hawk>
Subject: Re: [BUG] 2.4.21 - kernel BUG at dev.c:991
Date: Sat, 14 Jun 2003 03:04:03 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm experiencing a reproducible "kernel BUG at dev.c:991!" call from
> core/net/dev.c in 2.4.21.

I'm able to make things work by using the eepro100 driver instead of intel's e100.

-Chris

