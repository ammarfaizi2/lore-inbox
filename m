Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932535AbVHINLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932535AbVHINLd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 09:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVHINLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 09:11:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:403 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932535AbVHINLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 09:11:33 -0400
Subject: Re: [PATCH] 2.4.31 O_DIRECT support for ext3
From: Arjan van de Ven <arjan@infradead.org>
To: manoj.sharma@wipro.com
Cc: sct@redhat.com, akpm@zip.com.au, adilger@clusterfs.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <7352E281DE2FDC4E8F29EC48AAE1668C0910CF@blr-m3-msg.wipro.com>
References: <7352E281DE2FDC4E8F29EC48AAE1668C0910CF@blr-m3-msg.wipro.com>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 15:11:17 +0200
Message-Id: <1123593078.3839.25.camel@laptopd505.fenrus.org>
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

On Tue, 2005-08-09 at 18:35 +0530, manoj.sharma@wipro.com wrote:
> Hi,
> 
> This is back-port of O_DIRECT support for ext3 from 2.6 to 2.4.31
> kernel.
> 
> Any suggestions/comments ?

why?

personally I think this is way out of scope for a 2.4.x release in this
phase of 2.4's life.

(also you wrapped your patch)



