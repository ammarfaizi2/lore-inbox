Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVBSLtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVBSLtN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 06:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVBSLtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 06:49:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27316 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261538AbVBSLtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 06:49:09 -0500
Subject: Re: Should kirqd work on HT?
From: Arjan van de Ven <arjan@infradead.org>
To: ncunningham@cyclades.com
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1108810730.4098.44.camel@desktop.cunningham.myip.net.au>
References: <1108794699.4098.28.camel@desktop.cunningham.myip.net.au>
	 <4216E248.5070603@pobox.com>
	 <1108804063.4098.35.camel@desktop.cunningham.myip.net.au>
	 <1108805793.6304.75.camel@laptopd505.fenrus.org>
	 <1108810730.4098.44.camel@desktop.cunningham.myip.net.au>
Content-Type: text/plain
Date: Sat, 19 Feb 2005 12:49:02 +0100
Message-Id: <1108813743.6304.88.camel@laptopd505.fenrus.org>
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

On Sat, 2005-02-19 at 21:58 +1100, Nigel Cunningham wrote:
> Hi again.
> 
> Didn't realise it was going to take nothing to install, so I've done it.
> IRQs are running on cpu 1 now. Is there some documentation somewhere?
> I'm wondering whether I can compile kirqd out.

with irqbalance running yes you can compile kirqd out..


