Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422920AbWCXANK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422920AbWCXANK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 19:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422924AbWCXANK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 19:13:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2065 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422908AbWCXANI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 19:13:08 -0500
Date: Fri, 24 Mar 2006 01:13:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jing Min Zhao <zhaojignmin@hotmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org
Subject: Two comments on the H.323 conntrack/NAT helper
Message-ID: <20060324001307.GO22727@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two comments on the H.323 conntrack/NAT helper:
- the function prototypes in ip_nat_helper_h323.c are _ugly_,
  please move them to a header file
- is there a reason for not using EXPORT_SYMBOL_GPL?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

