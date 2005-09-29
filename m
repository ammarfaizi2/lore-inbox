Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVI2Hgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVI2Hgt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 03:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbVI2Hgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 03:36:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2466 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932083AbVI2Hgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 03:36:48 -0400
Subject: Re: Slow loading big kernel module in 2.6 on PPC platform
From: Arjan van de Ven <arjan@infradead.org>
To: Wilson Li <yongshenglee@yahoo.com>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050928213755.11544.qmail@web34102.mail.mud.yahoo.com>
References: <20050928213755.11544.qmail@web34102.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 09:36:42 +0200
Message-Id: <1127979403.2918.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The original module size on disk is around 3.3M bytes. Here's details
> of size.
> 
>    text    data     bss     dec     hex filename
> 2025644  263244  213024 2501912  262d18 mrbig.ko

wow that is a whole lot of GPL code ;)


