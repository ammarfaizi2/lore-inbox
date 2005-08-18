Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbVHRGvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbVHRGvH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 02:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbVHRGvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 02:51:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22722 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750857AbVHRGvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 02:51:06 -0400
Subject: Re: 2.2.26 kernel on FC1
From: Arjan van de Ven <arjan@infradead.org>
To: K Aruran <k_aruran@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050818052028.24133.qmail@web33502.mail.mud.yahoo.com>
References: <20050818052028.24133.qmail@web33502.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Thu, 18 Aug 2005 08:51:02 +0200
Message-Id: <1124347862.3220.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
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

On Wed, 2005-08-17 at 22:20 -0700, K Aruran wrote:
> Hai..
> 
> I want to install 2.2.26 kernel on FC1 (2.4.22) for
> testing purpose of my modem..
> 
> How can I install it...

you can't. Fedora Core 1 assumes a 2.4 kernel in MANY places, and an
NPTL capable kernel in somne.


