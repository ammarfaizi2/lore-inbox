Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268032AbTBMMOJ>; Thu, 13 Feb 2003 07:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268031AbTBMMOJ>; Thu, 13 Feb 2003 07:14:09 -0500
Received: from pizda.ninka.net ([216.101.162.242]:40089 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268029AbTBMMOH>;
	Thu, 13 Feb 2003 07:14:07 -0500
Date: Thu, 13 Feb 2003 04:09:18 -0800 (PST)
Message-Id: <20030213.040918.116107261.davem@redhat.com>
To: ashishk@caldera.com
Cc: ak@muc.de, linux-kernel@vger.kernel.org, alan@redhat.com, akpm@zip.com.au,
       jgarzik@mandrakesoft.com, linux-net@vger.kernel.org, ashishk@sco.com
Subject: Re: EtherLeak generic fix - for feedback & testing.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3.0.32.20030213175200.006cf7cc@indus.asia.caldera.com>
References: <3.0.32.20030213175200.006cf7cc@indus.asia.caldera.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ashish Kalra <ashishk@caldera.com>
   Date: Thu, 13 Feb 2003 17:52:06 +0500

   This is a kernel-2.4.13 patch for a "generic" fix for the Etherleak security
   issue and it works without making modifications to network device drivers. 

Not very interesting as we've fixed the problem and
updated all the necessary drivers already.
