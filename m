Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267504AbTGOMGI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 08:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267425AbTGOMGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 08:06:08 -0400
Received: from mail.convergence.de ([212.84.236.4]:31136 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S267323AbTGOMGA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 08:06:00 -0400
Message-ID: <3F13F19E.5050606@convergence.de>
Date: Tue, 15 Jul 2003 14:20:46 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20030715
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@osdl.org
Subject: [PATCH 0/17] Sync Linuxtv.org CVS with 2.6-test kernels
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

here comes a series of 17 patches that sync the Linuxtv.org DVB driver 
CVS with the 2.6-test series.

The mail subject contains a short description, longer descriptions are 
inlined at the beginning of each file.

The first 9 patches have been sent before, but have not been applied 
yet. So patches 10 to 17 are incremental patches, which might change 
files again.

Some highlights:
- saa7146 capture core has been updated
- dvb-core has been updated, especially the dvb-net functionality
- add new DVB-T frontend drivers for MT312 and TDA14005
- add a driver for the DVB-S Skystar2 card by Technisat
- add drivers for two Hauppauge USB DVB-T adapters
- add drivers for the Hexium Orion and Gemini frame grabber cards

Thanks for reading!

CU
Michael.


