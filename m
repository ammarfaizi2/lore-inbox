Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbVLGPtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVLGPtD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbVLGPtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:49:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24449 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751142AbVLGPtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:49:01 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Rob Landley <rob@landley.net>, Mark Lord <lkml@rtr.ca>,
       Adrian Bunk <bunk@stusta.de>, David Ranson <david@unsolicited.net>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@gmx.de>
In-Reply-To: <4395DDA8.8000003@tmr.com>
References: <20051203135608.GJ31395@stusta.de> <4394681B.20608@rtr.ca>
	 <1133800090.21641.17.camel@mindpipe> <200512051158.06882.rob@landley.net>
	 <4395DDA8.8000003@tmr.com>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 16:48:38 +0100
Message-Id: <1133970518.2869.37.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The other group is the people who use and depend on some feature, be it 
> cryptoloop, 8k stacks, ndiswrapper, ipchains, whatever... which is 
> scheduled for extinction. 

these are actually 2 groups

1) people who depend on an in-kernel features

2) people who depend on out of kernel / binary modules

treating them as one is not correct or fair to this thread.

