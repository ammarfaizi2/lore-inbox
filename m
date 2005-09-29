Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbVI2HoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVI2HoP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 03:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVI2HoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 03:44:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:37846 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932184AbVI2HoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 03:44:12 -0400
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
	the kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20050929040403.GE18716@alpha.home.local>
References: <43384E28.8030207@adaptec.com> <4339BFE9.1060604@pobox.com>
	 <4339CCD6.5010409@adaptec.com> <4339F9A8.2030709@pobox.com>
	 <433AFEB2.7090003@adaptec.com> <433B0457.7020509@pobox.com>
	 <433B14E1.6080201@adaptec.com> <433B217F.4060509@pobox.com>
	 <20050929040403.GE18716@alpha.home.local>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 09:44:08 +0200
Message-Id: <1127979848.2918.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
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

On Thu, 2005-09-29 at 06:04 +0200, Willy Tarreau wrote:
> On Wed, Sep 28, 2005 at 07:04:31PM -0400, Jeff Garzik wrote:
> > Linux is about getting things done, not being religious about 
> > specifications.  You are way too focused on the SCSI specs, and missing 
> > the path we need to take to achieve additional flexibility.
> > 
> > With Linux, it's all about evolution and the path we take.
> 
> Hmmm... I'm fine with "not being religious about specs", but I hope we
> try to respect them as much as possible

a spec describes how the hw works... how we do the sw piece is up to
us ;)

(I know the scsi stuff also provides sort of a reference "here is how
you can do it in sw" but I see that more as you "you need this
functionality" not "you need this exact architecture in your software")

