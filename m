Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267646AbUHJRRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267646AbUHJRRH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 13:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267630AbUHJRLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 13:11:54 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:51644 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S267645AbUHJRGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 13:06:17 -0400
Date: Tue, 10 Aug 2004 18:57:52 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: V13 <v13@priest.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       dsaxena@plexity.net, greg@kroah.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Remove spaces from PCI IDE pci_driver.name field
Message-ID: <20040810165752.GD21534@louise.pinerecords.com>
References: <20040810001316.GA7292@plexity.net> <20040810155701.GB21534@louise.pinerecords.com> <1092154407.10794.14.camel@mindpipe> <200408101952.18710.v13@priest.com> <1092156906.861.9.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092156906.861.9.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug-10 2004, Tue, 12:55 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> On Tue, 2004-08-10 at 12:52, V13 wrote:
> > On Tuesday 10 August 2004 19:13, Lee Revell wrote:
> > > On Tue, 2004-08-10 at 11:57, Tomas Szepe wrote:
> > > > Sure, but while with a GUI you can click on almost anything, on the
> > > > command line spaces in filenames have always been a real pain in
> > > > the ass, so let's not pretend otherwise.
> > >
> > > Ever heard of tab completion?  Think of it as click for the command
> > > line.
> > >
> > > Seriously, do you really *prefer* filenames like
> > > Foo_Bar-Baa_Baaz_Quux.mp3?
> > 
> > Anyone that writes scripts prefers filenames without spaces. It simplifies 
> > scripts *and* typing a lot. 
> > 
> > Card\ 01
> > Card\ 02
> > Cardinal
> > 
> > Now we have to write: cd Ca<tab>\ <tab>1<tab/space>
> 
> Eh, anyone who writes perl scripts on the command line doesn't mind
> surrounding an expression in quotes.

Except when the quotes are already open.
Let's drop this now, I can see where the thread is leading.

-- 
Tomas Szepe <szepe@pinerecords.com>
