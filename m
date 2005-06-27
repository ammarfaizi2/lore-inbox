Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVF0I2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVF0I2Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 04:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVF0I2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 04:28:25 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9106 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261937AbVF0I2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 04:28:17 -0400
Subject: Re: [RFC] SPI core -- revisited
From: Arjan van de Ven <arjan@infradead.org>
To: Vitaly Wool <vwool@dev.rtsoft.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42BF7496.7080204@dev.rtsoft.ru>
References: <20050626193621.8B8E44C4D1@abc.pervushin.pp.ru>
	 <200506270049.10970.adobriyan@gmail.com>
	 <1119819580.3215.47.camel@laptopd505.fenrus.org>
	 <42BF7496.7080204@dev.rtsoft.ru>
Content-Type: text/plain
Date: Mon, 27 Jun 2005 10:28:03 +0200
Message-Id: <1119860886.3186.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
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

On Mon, 2005-06-27 at 07:37 +0400, Vitaly Wool wrote:
> Arjan van de Ven wrote:
> 
> <snip>
> 
> >
> > ... or just kill the wrappers entirely!
> >
> >  
> >
> Nothing's gonna work in DMA case if he kills the wrappers.

how is that??

