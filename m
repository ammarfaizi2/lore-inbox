Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbRF1B7S>; Wed, 27 Jun 2001 21:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265479AbRF1B7I>; Wed, 27 Jun 2001 21:59:08 -0400
Received: from dnscache.cbr.au.asiaonline.net ([210.215.8.100]:4319 "EHLO
	dnscache.cbr.au.asiaonline.net") by vger.kernel.org with ESMTP
	id <S265477AbRF1B67>; Wed, 27 Jun 2001 21:58:59 -0400
Message-ID: <3B3A8EF4.8F8DF887@acm.org>
Date: Thu, 28 Jun 2001 11:57:08 +1000
From: Gareth Hughes <gareth.hughes@acm.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: VIA 686B/Data Corruption FAQ
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.viahardware.com/686bfaq.shtm

Couldn't find a mention of this in the archives, but those interested in
the VIA chipset issues should check this out.  The page contains the
following officail statement from VIA:

The data corruption error, which some web sites and people have reported
with the 686b Southbridge, is caused by incorrect bios registry setting
to the Northbridge. These bios settings were made by motherboard
manufacturers, in an attempt to fix a conflict with the Sound Blaster
Live Value cards. Information has been provided to all motherboard
manufacturers on how to correctly resolve both the data corruption error
and the Sound Blaster Live conflict. The patch released by VIA in the
4in1 4.31 drivers replicates the correct bios settings. We provided
this patch to make sure as many people got a fix to their Sound Blaster
Live problems as soon as possible. Most motherboard manufacturers have
now corrected their bios and the patch is not necessarily needed
although it will not harm any VIA based system if installed.

-- Gareth
