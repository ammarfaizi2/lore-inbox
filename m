Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVFFNfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVFFNfZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 09:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVFFNfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 09:35:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49108 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261426AbVFFNdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 09:33:47 -0400
Subject: RE: Stable 2.6.x.y kernel series...
From: Arjan van de Ven <arjan@infradead.org>
To: szonyi calin <caszonyi@yahoo.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, stable@kernel.org
In-Reply-To: <20050606132550.59940.qmail@web52909.mail.yahoo.com>
References: <20050606132550.59940.qmail@web52909.mail.yahoo.com>
Content-Type: text/plain
Date: Mon, 06 Jun 2005 15:33:33 +0200
Message-Id: <1118064814.5652.33.camel@laptopd505.fenrus.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> They are making some people believe in word "stable" ;-)
> It would be nice if they will be real stable (i.e. more fixes to
> the kernel tree).


this is a built in contradiction. to get more stable you want less
patches (at least you want to be VERY careful with which kinds of
patches you put in, which comes down to "less" generally)

