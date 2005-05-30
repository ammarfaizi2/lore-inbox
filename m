Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVE3VNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVE3VNJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 17:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVE3VLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 17:11:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26807 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261764AbVE3VGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 17:06:09 -0400
Subject: Re: Adaptec AIC-79xx HostRaid
From: Arjan van de Ven <arjan@infradead.org>
To: Eric Jones <ejones5@attglobal.net>
Cc: linux-kernel@vger.kernel.org,
       Clemente Aguiar <caguiar@madeiratecnopolo.pt>
In-Reply-To: <429B7D00.1080004@attglobal.net>
References: <429B7D00.1080004@attglobal.net>
Content-Type: text/plain
Date: Mon, 30 May 2005 23:06:04 +0200
Message-Id: <1117487164.7747.21.camel@laptopd505.fenrus.org>
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
	0.0 CASHCASHCASH           Contains at least 3 dollar signs in a row
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  But, for extra $$$, you can also buy the IBM feature "ServeRAID-7k"
> which is a small DIMM-sized plugin module that adds XOR parity generation and a small cache.
>  
> http://www-132.ibm.com/webapp/wcs/stores/servlet/ProductDisplay?productId=8735579&storeId=1&langId=-1&catalogId=-840 
> 
> 
> Adaptec calls this a "zero-slot" RAID solution, and it requires a special binary driver
> to recognize and handle the array functions.

I would be very suspicious about the claim that the xor stuff is done in
hardware and not in the binary part. I'm actually surprised that a linux
friendly company like IBM actually gets involved with binary drivers
like this though.... a bit disappointing.

but yeah this sounds like a really bad purchase.

