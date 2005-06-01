Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVFAM6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVFAM6p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 08:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVFAM6p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 08:58:45 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19418 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261190AbVFAM6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 08:58:41 -0400
Subject: Re: Swap maximum size documented ?
From: Arjan van de Ven <arjan@infradead.org>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: david.balazic@hermes.si, linux-kernel@vger.kernel.org
In-Reply-To: <20050601124025.GZ422@unthought.net>
References: <200506011225.j51CPDV23243@lastovo.hermes.si>
	 <20050601124025.GZ422@unthought.net>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 14:58:37 +0200
Message-Id: <1117630718.6271.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
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


> > The mkwap(8) man page claims, that currently the limit is 
> > 32 swap areas of maximum 2 gigabyte size (for x86 arch). 
> > 
> > Is that correct ? 
> 
> Not on 2.6 kernels, no.

it's not even true for 2.4 kernels btw; it was a 2.2 and before issue

