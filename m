Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbVLEVZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbVLEVZX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 16:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932537AbVLEVZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 16:25:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17583 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932536AbVLEVZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 16:25:22 -0500
Subject: Re: Linux in a binary world... a doomsday scenario
From: Arjan van de Ven <arjan@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Walrond <andrew@walrond.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1133817575.11280.18.camel@localhost.localdomain>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <200512051826.06703.andrew@walrond.org>
	 <1133817575.11280.18.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 22:24:38 +0100
Message-Id: <1133817888.9356.78.camel@laptopd505.fenrus.org>
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

On Mon, 2005-12-05 at 21:19 +0000, David Woodhouse wrote:
> On Mon, 2005-12-05 at 18:26 +0000, Andrew Walrond wrote:
> > > On December 6th, 2005 the kernel developers en mass decide that binary
> > > modules are legally fine and also essential for the progress of linux,
> > 
> > Has anyone (influential) actually being toying with this idea? I hope not, but 
> > if they are, I'd like to know who to lobby...
> 
> http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=e3c3374fbf7efe9487edc53cd10436ed641983aa


I think you're wrong on this. Not about thinking it should be reverted
per se, but in the big picture it's not linked to the scenario. One
export more or less doesn't matter at all. 

