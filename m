Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWENLsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWENLsH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 07:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWENLsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 07:48:06 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:42229 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751401AbWENLsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 07:48:05 -0400
Message-ID: <4467189F.8070508@online.de>
Date: Sun, 14 May 2006 13:46:39 +0200
From: Thomas Ilgner <thomas.ilgner@online.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: rmk+lkml@arm.linux.org.uk
Subject: card reader and misformatting >=2Gbyte
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:ef1d774c42e09778a3a6a5a7fbab7cb7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

i've got a problem with my 2Gbyte Sd-Card. It's an Ricoh R5C822 device included in my Samsung X20.
When I put in the card, dmesg shows up the following  error:

mmcblk0: mmc0:0002       1954816KiB
mmcblk0: unknown partition table

I've already formated the card to fat. And the same card with 1Gbyte works very well. BTW the manufactor is Extrememory. 
I've heard, there is a problem with USB card readers misformatting cards >= 2GB. How's the current status?

Bye 
Thomas

