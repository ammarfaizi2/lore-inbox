Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTGKPYi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 11:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263597AbTGKPYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 11:24:38 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:24227 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP id S263590AbTGKPYb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 11:24:31 -0400
Subject: Re: 2.5 'what to expect'
From: Steven Cole <elenstev@mesatop.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tomas Szepe <szepe@pinerecords.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030711151127.GA30378@work.bitmover.com>
References: <20030711140219.GB16433@suse.de>
	 <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk>
	 <20030711144617.GK10217@louise.pinerecords.com>
	 <1057935630.20637.19.camel@dhcp22.swansea.linux.org.uk>
	 <20030711151127.GA30378@work.bitmover.com>
Content-Type: text/plain
Organization: 
Message-Id: <1057937849.2337.4.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 11 Jul 2003 09:37:29 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-11 at 09:11, Larry McVoy wrote:
> On Fri, Jul 11, 2003 at 04:00:33PM +0100, Alan Cox wrote:
> > On Gwe, 2003-07-11 at 15:46, Tomas Szepe wrote:
> > > > > - gcc 3.2.2-5 as shipped by Red Hat generates incorrect code in the
> > > > >   kmalloc optimisation introduced in 2.5.71
> > > > >   See http://linus.bkbits.net:8080/linux-2.5/cset@1.1410
> > > > 
> > > > This URL appears wrong!
> > > 
> > > Nahh, that's just the same old annoying bkbits bug.  Try with lynx...
> > 
> > I did - it references a changeset unrelayed to kmalloc
> 
> I know, sorry.  The version numbers in BK are not stable, they can't be.
> You have to use the underlying internal version number.  If someone who
> knows can show me the output of 
> 
> 	bk changes -r<correct rev>
> 
> for that changeset I will figure out a way to have a URL that doesn't change
> and send it to Dave for that doc as well as post it there.

This looks like the right one as currently numbered.

http://linus.bkbits.net:8080/linux-2.5/cset@1.1215.127.10

Steven

