Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbUK3SOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbUK3SOh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbUK3SLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:11:05 -0500
Received: from canuck.infradead.org ([205.233.218.70]:61447 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262234AbUK3SGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 13:06:44 -0500
Subject: Re: 2.6.10-rc2-mm4
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041130095045.090de5ea.akpm@osdl.org>
References: <20041130095045.090de5ea.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1101837994.2640.67.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 30 Nov 2004 19:06:34 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 09:50 -0800, Andrew Morton wrote:
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm4/
> 
> - Various fixes and cleanups
> 
> - A decent-sized x86_64 update.
> 
> - x86_64 supports a fourth VM zone: ZONE_DMA32.  This may affect memory
>   reclaim, but shouldn't.


what is the purpose of such a zone ??

