Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268778AbUHaRiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268778AbUHaRiW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUHaRiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:38:22 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:51392 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268795AbUHaRef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:34:35 -0400
Date: Tue, 31 Aug 2004 19:34:25 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>, coreteam@netfilter.org
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netfilter-devel@lists.netfilter.org
Subject: 2.6.9-rc1: missing netfilter help texts
Message-ID: <20040831173425.GE3466@fs.tum.de>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following new netfilter options lack help texts:
- IP_NF_CT_ACCT
- IP_NF_MATCH_SCTP
- IP_NF_CT_PROTO_SCTP

Could someone add the help texts?

TIA
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

