Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263080AbVCXJeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263080AbVCXJeX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 04:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbVCXJeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 04:34:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:28588 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263080AbVCXJeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 04:34:19 -0500
Subject: Re: How's the nforce4 support in Linux?
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Asfand Yar Qazi <ay1204@qazi.f2s.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050324093032.GA14022@havoc.gtf.org>
References: <4242865D.90800@qazi.f2s.com>
	 <20050324093032.GA14022@havoc.gtf.org>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 10:34:12 +0100
Message-Id: <1111656852.6290.47.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
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


> 
> * "hardware firewall" -- sounds silly.  Pretty sure Linux doesn't support
> it in any case.
> 

probably just one of those things implemented in the binary drivers in
software, just like the "hardware" IDE raid is most of the time (3ware
being the positive exception there)


