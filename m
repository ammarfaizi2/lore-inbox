Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132359AbRDCRJU>; Tue, 3 Apr 2001 13:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132318AbRDCRJI>; Tue, 3 Apr 2001 13:09:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33799 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132359AbRDCRI3>; Tue, 3 Apr 2001 13:08:29 -0400
Subject: Re: EATA driver with DPT SmartRAID V
To: dyp@perchine.com (Denis Perchine)
Date: Tue, 3 Apr 2001 18:10:19 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200104031700.AAA02001@gw.ac-sw.com> from "Denis Perchine" at Apr 03, 2001 11:58:49 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kUJy-0008Sk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any other way to make it working under 2.4.x? Only working drivers 
> are up to 2.2.16. I tried to compile them for 2.2.17 from RH 6.2 updates, but 
> they hang up PC.

DPT (now Adaptec) posted beta drivers for the card. I've asked them to make
a few more changes for me but their change making cycle seems very slow and 
I'm waiting for the next round.
