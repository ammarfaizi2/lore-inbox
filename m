Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbVDDRL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVDDRL5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 13:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVDDRLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 13:11:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32717 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261295AbVDDRLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 13:11:16 -0400
Subject: Re: Assertion failure in journal_start_Rsmp_2519e07e()
From: Arjan van de Ven <arjan@infradead.org>
To: Eric Desjardins <eric.desjardins@discreet.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1112633954.11836.2.camel@oshawa.rd.discreet.qc.ca>
References: <1112633954.11836.2.camel@oshawa.rd.discreet.qc.ca>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 19:11:05 +0200
Message-Id: <1112634665.6270.66.camel@laptopd505.fenrus.org>
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

On Mon, 2005-04-04 at 12:59 -0400, Eric Desjardins wrote:
> Hi,
> 
> I'm having problem with my x86_64 workstation. I'm having about
> 5 kernels oops a day and usually I got that in the syslog:
> 
> Apr  4 12:45:07 oshawa kernel: Assertion failure in
> journal_start_Rsmp_2519e07e() at transaction.c:249:
> "handle->h_transaction->t_journal == journal"
> 
> I'm using:
> Linux oshawa 2.4.21-20.ELsmp #2 SMP Wed Mar 23 18:32:06 EST 2005 x86_64
> x86_64 x86_64 GNU/Linux.
> 
> Any idea where I should start to look at.

your RH support person?
Or at least an updated kernel...


