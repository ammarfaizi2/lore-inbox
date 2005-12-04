Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbVLDQl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbVLDQl1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 11:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVLDQl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 11:41:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13214 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932258AbVLDQl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 11:41:27 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051204161157.GB17846@merlin.emma.line.org>
References: <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com>
	 <20051203201945.GA4182@kroah.com>
	 <f0cc38560512031254j3b28d579s539be721c247c10a@mail.gmail.com>
	 <20051203211209.GA4937@kroah.com>
	 <f0cc38560512031331x3f4006e5sc2ff51414f07ada7@mail.gmail.com>
	 <1133645895.22170.33.camel@laptopd505.fenrus.org>
	 <f0cc38560512031353q27ee0a2dh70e283f53671b70f@mail.gmail.com>
	 <1133682973.5188.3.camel@laptopd505.fenrus.org>
	 <f0cc38560512040657i58cc08efqa8596c357fcea82e@mail.gmail.com>
	 <1133709038.5188.49.camel@laptopd505.fenrus.org>
	 <20051204161157.GB17846@merlin.emma.line.org>
Content-Type: text/plain
Date: Sun, 04 Dec 2005 17:41:20 +0100
Message-Id: <1133714480.5188.62.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-04 at 17:11 +0100, Matthias Andree wrote:
> On Sun, 04 Dec 2005, Arjan van de Ven wrote:
> 
> > On Sun, 2005-12-04 at 15:57 +0100, M. wrote:
> > 
> > > 
> > > if distros would align on those 6months versions those less
> > > experienced users would get 5 years support on those kernels. 
> > 
> > no distro gives 5 years of support for a kernel done every 6 months;
> > they start such projects more like every 18 to 24 months (SuSE used to
> > do it a bit more frequently but it seems they also slowed this down).
> 
> SUSE end-user distros (SUSE LINUX <version>) are released every 6 months
> or so, and are supported for 24 months. Their "enterprise server" is
> supported for 60 months though, SLES 9 forked off 9.1.

sure.. but they don't add new hw support really, and I'd not be
surprised if they rebase to a newer upstream kernel after a while. I
know we did that for RHL, eg RHL 7.(Y-1) got the kernel of RHL7.Y after
RHL7.Y was released, not only to keep the maintenance down, but more so
to get all the bugfixes and hardware support out to customers. 


