Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVKNNhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVKNNhu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 08:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVKNNhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 08:37:50 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:35804 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751121AbVKNNhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 08:37:50 -0500
Subject: Re: 2.6.15-rc1: kswapd crash
From: Arjan van de Ven <arjan@infradead.org>
To: Mark Lord <lkml@rtr.ca>
Cc: Adrian Bunk <bunk@stusta.de>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43788F17.1080507@rtr.ca>
References: <4377D1B2.8070003@rtr.ca> <20051114004758.GA5735@stusta.de>
	 <4377FFA7.4030400@rtr.ca> <20051114035616.GD5735@stusta.de>
	 <43788F17.1080507@rtr.ca>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 14:37:44 +0100
Message-Id: <1131975465.2821.33.camel@laptopd505.fenrus.org>
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


> It's not.  VMware had never been run to that point.

well the kernel modules are loaded...


