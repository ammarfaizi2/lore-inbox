Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbTANSFM>; Tue, 14 Jan 2003 13:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbTANSFM>; Tue, 14 Jan 2003 13:05:12 -0500
Received: from mail-gw1.credit-suisse.com ([198.240.212.28]:473 "EHLO
	mail-gw1.credit-suisse.com") by vger.kernel.org with ESMTP
	id <S264875AbTANSFL>; Tue, 14 Jan 2003 13:05:11 -0500
Message-ID: <F12E8D9F1EA37D4E9165C8D13ECA695201367303@sxchs017.csintra.net>
From: "Capaul Giachen F (KADA 12)" <flurin.capaul@csfs.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [Question] Assinging of IRQ to an ethernet card
Date: Tue, 14 Jan 2003 19:13:50 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain; charset="iso-8859-1"
X-Security: Prun-O-Matic by Gromit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> My ethernet card is unfortunately being assigned IRQ 19 instead of IRQ 
>> 11. 

>It could be your irq line wiring to the IOAPIC, can you try booting with 
>the 'noapic' kernel parameter?

Thanks, but I've tried this. It didn't work.

Cheers,

Flurin
