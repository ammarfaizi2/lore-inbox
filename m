Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVCPRAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVCPRAe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 12:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVCPRAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 12:00:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59858 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261301AbVCPRAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 12:00:30 -0500
Subject: Re: 2.6.11.x, EXTRAVERSION and module compatibility
From: Arjan van de Ven <arjan@infradead.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42386368.5030604@tls.msk.ru>
References: <42386368.5030604@tls.msk.ru>
Content-Type: text/plain
Date: Wed, 16 Mar 2005 18:00:22 +0100
Message-Id: <1110992423.6292.34.camel@laptopd505.fenrus.org>
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

On Wed, 2005-03-16 at 19:48 +0300, Michael Tokarev wrote:
> As far as I can see, the "super-stable" kernel releases
> should not affect module ABI in any way
>

that is an assumption that seems quite invalid to me in general at
least.


