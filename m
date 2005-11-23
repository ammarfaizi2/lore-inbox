Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbVKWOlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbVKWOlI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 09:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbVKWOlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 09:41:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16265 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750840AbVKWOlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 09:41:06 -0500
Subject: Re: Dual opteron various segfaults with 2.6.14.2 and earlier
	kernels
From: Arjan van de Ven <arjan@infradead.org>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200511231537.49320.cova@ferrara.linux.it>
References: <200511231537.49320.cova@ferrara.linux.it>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 15:41:00 +0100
Message-Id: <1132756861.2795.49.camel@laptopd505.fenrus.org>
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

On Wed, 2005-11-23 at 15:37 +0100, Fabio Coatti wrote:
> Hi all,
> I'm seeing several segfaults on a couple of HP DL585 Dual Opterons, 8Gb ram 
> each.


are you using the gentoo buildstuff for this? eg libjail or whatever
it's called?

