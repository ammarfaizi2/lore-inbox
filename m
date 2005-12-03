Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVLCRWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVLCRWn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 12:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbVLCRWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 12:22:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39832 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932089AbVLCRWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 12:22:43 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051203162755.GA31405@merlin.emma.line.org>
References: <20051203135608.GJ31395@stusta.de>
	 <1133620598.22170.14.camel@laptopd505.fenrus.org>
	 <20051203152339.GK31395@stusta.de>
	 <20051203162755.GA31405@merlin.emma.line.org>
Content-Type: text/plain
Date: Sat, 03 Dec 2005 18:22:35 +0100
Message-Id: <1133630556.22170.26.camel@laptopd505.fenrus.org>
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


> Exactly that, and kernel interfaces going away just to annoy binary
> module providers also hurts third-party OSS modules, such as
> Fujitsu-Siemens's ServerView agents.

in kernel API never was and never will be stable, that's entirely
irrelevant and independent of the proposal at hand.



