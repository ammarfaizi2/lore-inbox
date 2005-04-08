Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262913AbVDHSeD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbVDHSeD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 14:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbVDHSeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 14:34:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43201 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262913AbVDHSeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 14:34:00 -0400
Subject: Re: kernel compile
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Allison <fireflyblue@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050408181713.GD15688@stusta.de>
References: <17d798805040716097d82c0d@mail.gmail.com>
	 <20050408181713.GD15688@stusta.de>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 20:33:50 +0200
Message-Id: <1112985230.6278.83.camel@laptopd505.fenrus.org>
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

On Fri, 2005-04-08 at 20:17 +0200, Adrian Bunk wrote:
> On Thu, Apr 07, 2005 at 07:09:18PM -0400, Allison wrote:
> 
> > Hi,
> > 
> > Is it possible to compile a 2.4.20 kernel on a 2.6 system ?
> > And use the new image successfully ?
> 
> It doesn't matter what the system you are compiling on is running.

... as long as you have a modutils installed that can deal with 2.4
kernels. Not all distros that ship 2.6 ship a modutils that does...


