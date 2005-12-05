Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbVLEUk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbVLEUk3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 15:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbVLEUk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 15:40:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:12680 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751454AbVLEUk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 15:40:28 -0500
Subject: Re: Broadcom 43xx first results
From: Arjan van de Ven <arjan@infradead.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Michael Buesch <mbuesch@freenet.de>, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de
In-Reply-To: <20051205203517.GA23782@elf.ucw.cz>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de>
	 <20051205194016.GA23892@elf.ucw.cz> <200512052114.16651.mbuesch@freenet.de>
	 <20051205203517.GA23782@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 21:40:20 +0100
Message-Id: <1133815221.9356.66.camel@laptopd505.fenrus.org>
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

On Mon, 2005-12-05 at 21:35 +0100, Pavel Machek wrote:
> Hi!
> 
> > > > BCM43xx driver:
> > > > http://bcm43xx.berlios.de
> > > > Required SoftMAC Layer:
> > > > http://softmac.sipsolutions.net
> > > 
> > > ...but don't feel like playing with *two* different revision control
> > > systems just to get the sources. Do you think you could just mail the
> > > diffs to the list?
> > 
> > The diffs will be outdated within minutes ;)
> > Both trees are rapidly changing.
> 
> Okay, at least for preview... it would be nice. It can't change _that_
> fast.

maybe daily snapshots would be nice for this...

