Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVDTTTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVDTTTt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 15:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVDTTTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 15:19:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29852 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261709AbVDTTTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 15:19:47 -0400
Subject: Re: [2.6 patch] drivers/ieee1394/: remove unneeded EXPORT_SYMBOL's
From: Arjan van de Ven <arjan@infradead.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <42668CE3.5070606@s5r6.in-berlin.de>
References: <20050417195706.GD3625@stusta.de>
	 <20050419191328.GJ1111@conscoop.ottawa.on.ca>
	 <1113939827.6277.86.camel@laptopd505.fenrus.org>
	 <42657F7C.8060305@s5r6.in-berlin.de>
	 <1113981989.6238.30.camel@laptopd505.fenrus.org>
	 <426683E9.4080708@s5r6.in-berlin.de>
	 <1114014925.6238.91.camel@laptopd505.fenrus.org>
	 <42668CE3.5070606@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Wed, 20 Apr 2005 21:19:41 +0200
Message-Id: <1114024782.6238.101.camel@laptopd505.fenrus.org>
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

On Wed, 2005-04-20 at 19:09 +0200, Stefan Richter wrote:
> Arjan van de Ven wrote:
> > If nothing is using an api
> 
> Check the archive.

I don't care and in fact ignore external drivers that don't ever want to
get upstream. If there is a driver that wants this surely it wants to go
upstream soonish ?
 

