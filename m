Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbVFYMbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbVFYMbn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 08:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVFYMbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 08:31:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:217 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261189AbVFYMaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 08:30:21 -0400
Subject: Re: i2o driver and OOM killer on 2.6.9
From: Arjan van de Ven <arjan@infradead.org>
To: hyoshiok@miraclelinux.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <98df96d305062503281efa5f5a@mail.gmail.com>
References: <98df96d305062503281efa5f5a@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 25 Jun 2005 14:30:12 +0200
Message-Id: <1119702614.3157.19.camel@laptopd505.fenrus.org>
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

On Sat, 2005-06-25 at 19:28 +0900, Hiro Yoshioka wrote:
> Hi,
> 
> I got the following OOM killer on 2.6.9 by iozone. The machine has a
> i2o driver so it may have issues.


2.6.9 is a really really old kernel by now; you're probably much better
off using 2.6.12 

