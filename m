Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVLDPLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVLDPLi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 10:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbVLDPLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 10:11:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27539 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932244AbVLDPLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 10:11:37 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051204150804.GA17846@merlin.emma.line.org>
References: <20051203162755.GA31405@merlin.emma.line.org>
	 <1133630556.22170.26.camel@laptopd505.fenrus.org>
	 <20051203230520.GJ25722@merlin.emma.line.org>
	 <43923DD9.8020301@wolfmountaingroup.com>
	 <20051204121209.GC15577@merlin.emma.line.org>
	 <1133699555.5188.29.camel@laptopd505.fenrus.org>
	 <20051204132813.GA4769@merlin.emma.line.org>
	 <1133703338.5188.38.camel@laptopd505.fenrus.org>
	 <20051204142551.GB4769@merlin.emma.line.org>
	 <1133707855.5188.41.camel@laptopd505.fenrus.org>
	 <20051204150804.GA17846@merlin.emma.line.org>
Content-Type: text/plain
Date: Sun, 04 Dec 2005 16:11:34 +0100
Message-Id: <1133709094.5188.51.camel@laptopd505.fenrus.org>
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


> Perhaps the dates give a clue. Since when has Linux had IPMI in the
> baseline code?

2.4.21 already had it, so it's been quite a while

