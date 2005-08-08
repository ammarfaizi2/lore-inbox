Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbVHHNJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbVHHNJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 09:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbVHHNJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 09:09:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29371 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750859AbVHHNJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 09:09:13 -0400
Subject: Re: I can not  build a new kernel image with a assembly module
From: Arjan van de Ven <arjan@infradead.org>
To: mhb <badrpayam@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050808130246.58431.qmail@web60517.mail.yahoo.com>
References: <20050808130246.58431.qmail@web60517.mail.yahoo.com>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 15:09:05 +0200
Message-Id: <1123506545.3245.41.camel@laptopd505.fenrus.org>
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

On Mon, 2005-08-08 at 06:02 -0700, mhb wrote:
> Hi
> 
> I had added an assembly program to the networking
> section of kernel linux 2.2.16 without any problem.
> But when I add it to kerenel 2.4.1 I could build that
> kernel, but I faced with kernel panic error when I
> boot
> system with new builded image. I use the following
> Make file to build It in the 2.4.1 kernel. 

2.4.1 is OLD and really crappy

also you forgot to attach the sourcecode of your file.


