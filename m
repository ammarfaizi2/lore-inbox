Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVDLF37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVDLF37 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 01:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVDLFXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:23:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62888 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262020AbVDLEYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 00:24:21 -0400
Subject: Re: New SCM and commit list
From: Arjan van de Ven <arjan@infradead.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1113255109.5827.46.camel@mulgrave>
References: <1113174621.9517.509.camel@gaston>
	 <Pine.LNX.4.58.0504101621200.1267@ppc970.osdl.org>
	 <1113189922.9899.6.camel@mulgrave> <20050411205317.GA26246@kroah.com>
	 <Pine.LNX.4.58.0504111424270.1267@ppc970.osdl.org>
	 <1113255109.5827.46.camel@mulgrave>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 06:24:06 +0200
Message-Id: <1113279847.6282.0.camel@laptopd505.fenrus.org>
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

On Mon, 2005-04-11 at 16:31 -0500, James Bottomley wrote:
> On Mon, 2005-04-11 at 14:26 -0700, Linus Torvalds wrote:
> > I don't think kernel.org mirrors the private home directories, so it you
> > do _temporary_ trees, just make them readable in your private home
> > directory rather than in /pub/linux/kernel/people. For people with 
> > kernel.org accounts, we can use that as the "bkbits.net" thing.
> 
> It's also going to be a slight problem for those of us who don't have a
> kernel.org account...although I think the hosting I use on the parisc
> website might actually be outside the HP firewall, so I can probably beg
> for it to run any protocol you need (like rsync).

rsync also runs over ssh so if you can ssh in you can rsync to it

