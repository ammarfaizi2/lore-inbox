Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbULTMQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbULTMQL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 07:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbULTMQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 07:16:11 -0500
Received: from canuck.infradead.org ([205.233.218.70]:1285 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261485AbULTMQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 07:16:10 -0500
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
From: Arjan van de Ven <arjan@infradead.org>
To: Arne Caspari <arnem@informatik.uni-bremen.de>
Cc: Adrian Bunk <bunk@stusta.de>, bcollins@debian.org,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <41C694E0.8010609@informatik.uni-bremen.de>
References: <20041220015320.GO21288@stusta.de>
	 <41C694E0.8010609@informatik.uni-bremen.de>
Content-Type: text/plain
Date: Mon, 20 Dec 2004 13:15:43 +0100
Message-Id: <1103544944.4133.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-20 at 10:01 +0100, Arne Caspari wrote:
> Adrian,
> 
> Some of these symbols are used by the open source driver "video-2-1394" 
> ( http://sourceforge.net/projects/video-2-1394 ).


are you going to submit that driver for inclusion any time soon ?

