Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267605AbUHJRBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267605AbUHJRBM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 13:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267613AbUHJQ6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:58:17 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:15238 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267604AbUHJQyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:54:51 -0400
Subject: Re: [PATCH 2.6] Remove spaces from PCI IDE pci_driver.name field
From: Lee Revell <rlrevell@joe-job.com>
To: V13 <v13@priest.com>
Cc: Tomas Szepe <szepe@pinerecords.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       dsaxena@plexity.net, greg@kroah.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408101952.18710.v13@priest.com>
References: <20040810001316.GA7292@plexity.net>
	 <20040810155701.GB21534@louise.pinerecords.com>
	 <1092154407.10794.14.camel@mindpipe>  <200408101952.18710.v13@priest.com>
Content-Type: text/plain
Message-Id: <1092156906.861.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 12:55:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 12:52, V13 wrote:
> On Tuesday 10 August 2004 19:13, Lee Revell wrote:
> > On Tue, 2004-08-10 at 11:57, Tomas Szepe wrote:
> > > Sure, but while with a GUI you can click on almost anything, on the
> > > command line spaces in filenames have always been a real pain in
> > > the ass, so let's not pretend otherwise.
> >
> > Ever heard of tab completion?  Think of it as click for the command
> > line.
> >
> > Seriously, do you really *prefer* filenames like
> > Foo_Bar-Baa_Baaz_Quux.mp3?
> 
> Anyone that writes scripts prefers filenames without spaces. It simplifies 
> scripts *and* typing a lot. 
> 
> Card\ 01
> Card\ 02
> Cardinal
> 
> Now we have to write: cd Ca<tab>\ <tab>1<tab/space>

Eh, anyone who writes perl scripts on the command line doesn't mind
surrounding an expression in quotes.

Lee

