Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263371AbTDCM3U>; Thu, 3 Apr 2003 07:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263372AbTDCM3U>; Thu, 3 Apr 2003 07:29:20 -0500
Received: from pizda.ninka.net ([216.101.162.242]:44949 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263371AbTDCM3U>;
	Thu, 3 Apr 2003 07:29:20 -0500
Date: Thu, 03 Apr 2003 04:34:57 -0800 (PST)
Message-Id: <20030403.043457.42662116.davem@redhat.com>
To: chas@locutus.cmf.nrl.navy.mil
Cc: bunk@fs.tum.de, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.66-mm3: drivers/atm/iphase.c doesn't compile 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200304031224.h33CO3Gi016160@locutus.cmf.nrl.navy.mil>
References: <20030403121422.GJ3693@fs.tum.de>
	<200304031224.h33CO3Gi016160@locutus.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@locutus.cmf.nrl.navy.mil>
   Date: Thu, 03 Apr 2003 07:24:03 -0500

   In message <20030403121422.GJ3693@fs.tum.de>,Adrian Bunk writes:
   >drivers/atm/iphase.c:2979: `pad' undeclared (first use in this function)
   >drivers/atm/iphase.c:2979: (Each undeclared identifier is reported only once
   >drivers/atm/iphase.c:2979: for each function it appears in.)
   
   i missed this one since i normally dont compile the iphase with debugging.
   apply the following please to the 2.4 and 2.5 tree:

Applied, thanks Chas.
