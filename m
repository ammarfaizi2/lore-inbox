Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbVLDH4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbVLDH4T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 02:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVLDH4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 02:56:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34490 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751329AbVLDH4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 02:56:18 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Arjan van de Ven <arjan@infradead.org>
To: "M." <vo.sinh@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <f0cc38560512031353q27ee0a2dh70e283f53671b70f@mail.gmail.com>
References: <20051203135608.GJ31395@stusta.de>
	 <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com>
	 <20051203201945.GA4182@kroah.com>
	 <f0cc38560512031254j3b28d579s539be721c247c10a@mail.gmail.com>
	 <20051203211209.GA4937@kroah.com>
	 <f0cc38560512031331x3f4006e5sc2ff51414f07ada7@mail.gmail.com>
	 <1133645895.22170.33.camel@laptopd505.fenrus.org>
	 <f0cc38560512031353q27ee0a2dh70e283f53671b70f@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 04 Dec 2005 08:56:13 +0100
Message-Id: <1133682973.5188.3.camel@laptopd505.fenrus.org>
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


> >
> > > . Another
> > > advantage would be to benefit external projects and hardware producers
> > > writing open drivers, enlowering the effort in writing and mantaining
> > > a driver.
> >
> > there is an even better model for those: Get it merged into kernel.org!
> >
> >
> > There is an even bigger deal here: even if you're not ready to get
> > merged yet, staying on the same old version for 6 months is NOT going to
> > help you. In fact it's worse: it is 10x easier to deal with 6 small
> > steps of 1 month than to deal with 1 big step of 6 months.
> >
> >
> from the kernel.org point of view it does make sense but from users
> pov i think no. Users stuck with old drivers not actively mantained
> would benefit from this.

actually no. since that only buys them a few months at most, and then
you're entirely stuck again. And patching it up after 6 months is a lot
harder than doing smaller steps of 1 month, especially for less
experienced people.


> There are some open drivers wrote by hardware mantainers which will
> never get into kernel.org cause of code not following kernel style
> guides and so on. 

which ones did you have in mind?



