Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbVKNHuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbVKNHuh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 02:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbVKNHuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 02:50:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:1734 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750976AbVKNHug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 02:50:36 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051114021127.GC5735@stusta.de>
References: <20051114021127.GC5735@stusta.de>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 08:50:28 +0100
Message-Id: <1131954628.2821.3.camel@laptopd505.fenrus.org>
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

On Mon, 2005-11-14 at 03:11 +0100, Adrian Bunk wrote:
> It seems most problems with 4k stacks are already resolved.
> 
> I'd like to see this patch to always use 4k stacks in -mm now for 
> finding any remaining problems before submitting this patch for
> 2.6.16.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Arjan van de Ven <arjan@infradead.org>
> 

