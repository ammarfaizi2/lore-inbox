Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316682AbSF0ANR>; Wed, 26 Jun 2002 20:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316695AbSF0ANQ>; Wed, 26 Jun 2002 20:13:16 -0400
Received: from zeus.kernel.org ([204.152.189.113]:19142 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S316682AbSF0ANP> convert rfc822-to-8bit;
	Wed, 26 Jun 2002 20:13:15 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: David Weeks <dweeks02@tampabay.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Chipset support for HP Pavilion zt1130 (aka: via pl133t)
Date: Wed, 26 Jun 2002 20:12:11 -0400
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200206262012.11366.dweeks02@tampabay.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about the "shotgun" targeted bug report....

I've recently bought an HP zt1130 Pavilion Laptop.  I first installed store 
bought RedHat 7.2, and did not have sound nor power management.  I hacked a 
little, but saw RedHat 7.3 out (v.2.4.18), and did a clean install via their 
iso files.

All the same, no sound, no power management. So I looked further, reading off 
the VIA Tech  website. (http://www.via.com.tw/en/ProSavage 
Chipsets/prosav_index.jsp)  On that site, I see that my laptop (dmesg) 
configd the PM133 but the chipset seems to be their PL133T instead.  So at 
this point it seems a mis-identified chipset ID bug.

Thanks,

David Weeks

-- 
dweeks02@tampabay.rr.com
813-236-2009
