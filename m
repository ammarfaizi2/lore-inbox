Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263165AbRE1VXB>; Mon, 28 May 2001 17:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263170AbRE1VWv>; Mon, 28 May 2001 17:22:51 -0400
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:21008 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S263165AbRE1VWi>;
	Mon, 28 May 2001 17:22:38 -0400
Message-ID: <3B12C1A2.123C15BE@bigfoot.com>
Date: Mon, 28 May 2001 15:22:42 -0600
From: Dylan Griffiths <Dylan_G@bigfoot.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Broken memory init on VIA KX133
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I'm wondering if anyone knows/has a fix for memory past 64mb not being
detected (unless you use append="mem=...M" in lilo) on the Via VT8371
[KX133] North bridge.   (Please CC any replies since I'm off kernel list
atm.)
--
    www.kuro5hin.org -- technology and culture, from the trenches.
