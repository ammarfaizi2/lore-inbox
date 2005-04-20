Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVDTH0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVDTH0h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 03:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVDTH0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 03:26:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57999 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261179AbVDTH0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 03:26:35 -0400
Subject: Re: [2.6 patch] drivers/ieee1394/: remove unneeded EXPORT_SYMBOL's
From: Arjan van de Ven <arjan@infradead.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <42657F7C.8060305@s5r6.in-berlin.de>
References: <20050417195706.GD3625@stusta.de>
	 <20050419191328.GJ1111@conscoop.ottawa.on.ca>
	 <1113939827.6277.86.camel@laptopd505.fenrus.org>
	 <42657F7C.8060305@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Wed, 20 Apr 2005 09:26:29 +0200
Message-Id: <1113981989.6238.30.camel@laptopd505.fenrus.org>
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

On Wed, 2005-04-20 at 00:00 +0200, Stefan Richter wrote:
> Arjan van de Ven wrote:
> > On Tue, 2005-04-19 at 15:13 -0400, Jody McIntyre wrote:
> >> On Sun, Apr 17, 2005 at 09:57:07PM +0200, Adrian Bunk wrote:
> >> > This patch removes unneeded EXPORT_SYMBOL's.
> ...
> >> Given the objections to your December patch, why should we accept this
> >> one now?
> > 
> > since there still isn't a user ??
> 
> There are users (though not in "the" kernel at the moment)

nor for the last 5 months... how long will it be ?

