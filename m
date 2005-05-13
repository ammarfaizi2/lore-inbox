Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbVEMEQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbVEMEQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 00:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262232AbVEMEQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 00:16:27 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38669 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262230AbVEMEQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 00:16:24 -0400
Date: Fri, 13 May 2005 06:16:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Julian Anastasov <ja@ssi.bg>,
       Wensong Zhang <wensong@linuxvirtualserver.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Status of net/ipv4/ipvs/ip_vs_proto_icmp.c?
Message-ID: <20050513041622.GE3603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

can anyone explain the status of?

This file is always included in the kernel if CONFIG_IP_VS=y, but it's 
completely unused.

Will it be made working in the forseeable future or is it a candidate 
for removal?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

