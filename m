Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVBGPo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVBGPo6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 10:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVBGPo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 10:44:58 -0500
Received: from kludge.physics.uiowa.edu ([128.255.33.129]:5395 "EHLO
	kludge.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id S261157AbVBGPn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 10:43:59 -0500
Date: Mon, 7 Feb 2005 09:43:27 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: [ATTN: Dmitry Torokhov] About the trackpad and 2.6.11-rc[23] but not -rc1
Message-ID: <20050207154326.GA13539@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Sorry; I accidentally deleted my email and your response, Dmitry.  :/
Anyhow, here is /proc/bus/input/devices

$ cat /proc/bus/input/devices 
I: Bus=0011 Vendor=0001 Product=0001 Version=ab41
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd event0 
B: EV=120013 
B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe 
B: MSC=10 
B: LED=7 

I: Bus=0011 Vendor=0002 Product=0001 Version=0000
N: Name="PS/2 Generic Mouse"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse0 event1 
B: EV=7 
B: KEY=70000 0 0 0 0 0 0 0 0 
B: REL=3 

This is both a trackpad and an eraser-mouse in one device, so far as
  I can tell.  It's in my Dell Inspiron 8600.

-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
      Graduate Student in Physics, Freelance Free Software Developer
