Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270089AbRHGFzG>; Tue, 7 Aug 2001 01:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270088AbRHGFy4>; Tue, 7 Aug 2001 01:54:56 -0400
Received: from 054.002.dsl.pth.iprimus.net.au ([210.50.29.54]:32269 "EHLO
	mail.opensystems.net.au") by vger.kernel.org with ESMTP
	id <S270087AbRHGFyn>; Tue, 7 Aug 2001 01:54:43 -0400
From: "Peter Robinson" <peterr@opensystems.net.au>
To: <mattwu@acersoftech.com.cn>, <linux-kernel@vger.kernel.org>
Subject: ALi 5451 Audio Core (trident driver)
Date: Tue, 7 Aug 2001 13:53:45 +0800
Message-ID: <000a01c11f05$52b78160$0b01a8c0@pbr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt, All,

The updates that went into 2.4.7 broke the trident sound driver on my
notebook (Acer Travelmate 524TXV) with the ALi 5451 Audio core. It loads all
right and doesn't complain but when I play an mp3 nothing happens. If I back
the kernel back to 2.4.6 it works fine, if I go to 2.4.8pre4 same problems,
if I run 2.4.7 / 2.4.8pre4 with the trident.c trident.h from the 2.4.6
kernel it works fine. I noticed that the new version of the driver changes
some power management stuff and I don't know whether this has anything to do
with the way my power management is configured but it doesn't appear to. I'm
currently running 2.4.8pre4 with the 2.4.6 driver as mentioned above and
works fine but I just thought I'd pass this one. Please feel free to email
me any patches for testing.

Regards
Peter

