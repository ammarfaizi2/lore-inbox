Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289039AbSAIV7S>; Wed, 9 Jan 2002 16:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289038AbSAIV7J>; Wed, 9 Jan 2002 16:59:09 -0500
Received: from mail.zeelandnet.nl ([212.115.192.194]:44490 "HELO
	mail.zeelandnet.nl") by vger.kernel.org with SMTP
	id <S289039AbSAIV7B>; Wed, 9 Jan 2002 16:59:01 -0500
Message-ID: <003e01c19950$938ed790$7800a8c0@darkskywinblow>
From: "Dennis Fleurbaaij" <dennis@core-lan.nl>
To: <linux-kernel@vger.kernel.org>
Subject: arch/i386/kernel/pci-irq.c
Date: Wed, 9 Jan 2002 21:59:49 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have stumbled upon an error in linux 2.4 that prevents my laptop from
using it's PCMCIA and PS2 mouse together. This is with every known 2.4
kernel and is a result of the BIOS not acknowleging the cardbus controller.


