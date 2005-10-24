Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVJXM3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVJXM3u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 08:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbVJXM3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 08:29:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7564 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750700AbVJXM3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 08:29:49 -0400
Subject: Re: Information on ioctl32
From: Arjan van de Ven <arjan@infradead.org>
To: James Hansen <linux-kernel-list@f0rmula.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <435CD312.4090007@f0rmula.com>
References: <4358CF73.3020602@f0rmula.com>
	 <200510241132.45334.arnd@arndb.de> <435CBBFF.7000704@f0rmula.com>
	 <200510241320.53335.arnd@arndb.de>  <435CD312.4090007@f0rmula.com>
Content-Type: text/plain
Date: Mon, 24 Oct 2005 14:29:35 +0200
Message-Id: <1130156976.2775.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-24 at 13:26 +0100, James Hansen wrote:

> I should probably mention that this is a 3rd party device driver for a 
> PCI card, which is not part of the kernel itself.

can you post the url to the sourcecode of the driver? Maybe you should
try to get it to be part of the kernel itself, that is a lot nicer...
(and not even THAT hard)



