Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263748AbRGEKhK>; Thu, 5 Jul 2001 06:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263806AbRGEKhB>; Thu, 5 Jul 2001 06:37:01 -0400
Received: from pD951F626.dip.t-dialin.net ([217.81.246.38]:23046 "EHLO
	emma1.emma.line.org") by vger.kernel.org with ESMTP
	id <S263748AbRGEKgv>; Thu, 5 Jul 2001 06:36:51 -0400
Date: Thu, 5 Jul 2001 12:36:49 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.6 Configure.help incomplete :-(
Message-ID: <20010705123649.B16700@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are still a lot of help texts missing from Configure.help,
CONFIG_AIC7XXXX_BUILD_FIRMWARE to name just one example.

I'm pretty annoyed by RELEASE versions that don't have all options
documented. If a module doesn't come with proper documentation for all
its options, drop it. 

How is a non-hacker supposed to configure the kernel if he doesn't even
have the faintest clue about the options?

Linux is the system with the worst official documentation anyhow,
compared to the "monolithic" BSD variants.

I appreciate efforts by ESR to get the documentation complete, but
evidently, the "good" way not enough.

A complex system without proper documentation is worth _nothing_.

-- 
Matthias Andree
