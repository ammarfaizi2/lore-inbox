Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVDSToK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVDSToK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 15:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVDSToK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 15:44:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16005 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261636AbVDSToH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 15:44:07 -0400
Subject: Re: [2.6 patch] drivers/ieee1394/: remove unneeded EXPORT_SYMBOL's
From: Arjan van de Ven <arjan@infradead.org>
To: Jody McIntyre <scjody@steamballoon.com>
Cc: Adrian Bunk <bunk@stusta.de>, bcollins@debian.org,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050419191328.GJ1111@conscoop.ottawa.on.ca>
References: <20050417195706.GD3625@stusta.de>
	 <20050419191328.GJ1111@conscoop.ottawa.on.ca>
Content-Type: text/plain
Date: Tue, 19 Apr 2005 21:43:46 +0200
Message-Id: <1113939827.6277.86.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-19 at 15:13 -0400, Jody McIntyre wrote:
> On Sun, Apr 17, 2005 at 09:57:07PM +0200, Adrian Bunk wrote:
> > This patch removes unneeded EXPORT_SYMBOL's.
> 
> Didn't you already send something like this (with fewer removals, mind
> you) in December?
> 
> http://marc.theaimsgroup.com/?l=linux1394-devel&m=110350765817261&w=2
> 
> Given the objections to your December patch, why should we accept this
> one now?

since there still isn't a user ??


