Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVBSJhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVBSJhR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 04:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVBSJhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 04:37:16 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20915 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261700AbVBSJgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 04:36:44 -0500
Subject: Re: Should kirqd work on HT?
From: Arjan van de Ven <arjan@infradead.org>
To: ncunningham@cyclades.com
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1108804063.4098.35.camel@desktop.cunningham.myip.net.au>
References: <1108794699.4098.28.camel@desktop.cunningham.myip.net.au>
	 <4216E248.5070603@pobox.com>
	 <1108804063.4098.35.camel@desktop.cunningham.myip.net.au>
Content-Type: text/plain
Date: Sat, 19 Feb 2005 10:36:33 +0100
Message-Id: <1108805793.6304.75.camel@laptopd505.fenrus.org>
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

On Sat, 2005-02-19 at 20:07 +1100, Nigel Cunningham wrote:
> Hi Jeff.
> 
> On Sat, 2005-02-19 at 17:52, Jeff Garzik wrote:
> > Nigel Cunningham wrote:
> > What are the results of running irqbalanced?
> 
> You mean the debugging output? I can reenable it and record the results
> if that's what you mean.

no Jeff meant
http://people.redhat.com/arjanv/irqbalance/
that app most likely....


