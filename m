Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262604AbVCVKD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbVCVKD5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 05:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262602AbVCVKD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 05:03:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:7597 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262601AbVCVKDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 05:03:49 -0500
Subject: Re: 2.6.11: suspending laptop makes system randomly unstable
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
In-Reply-To: <20050322015538.5db28ed5.akpm@osdl.org>
References: <422618F0.3020508@telefonica.net>
	 <20050321141049.5d804609.akpm@osdl.org> <423FE7C5.8080402@telefonica.net>
	 <20050322015538.5db28ed5.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 11:03:39 +0100
Message-Id: <1111485819.7096.58.camel@laptopd505.fenrus.org>
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


> Also, I'd consider it a regression that you had to go and find new X
> drivers due to a kernel change.  We shouldn't do that.

depends really on how bad the bug in the X driver was....
there is limits on how bug-2-bug compatible we can and want to be...


