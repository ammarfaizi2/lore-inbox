Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTGKO5f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 10:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTGKO5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 10:57:35 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:33215 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S263025AbTGKO5c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 10:57:32 -0400
Date: Fri, 11 Jul 2003 08:11:27 -0700
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tomas Szepe <szepe@pinerecords.com>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030711151127.GA30378@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Tomas Szepe <szepe@pinerecords.com>,
	Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030711140219.GB16433@suse.de> <1057933578.20636.17.camel@dhcp22.swansea.linux.org.uk> <20030711144617.GK10217@louise.pinerecords.com> <1057935630.20637.19.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057935630.20637.19.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 04:00:33PM +0100, Alan Cox wrote:
> On Gwe, 2003-07-11 at 15:46, Tomas Szepe wrote:
> > > > - gcc 3.2.2-5 as shipped by Red Hat generates incorrect code in the
> > > >   kmalloc optimisation introduced in 2.5.71
> > > >   See http://linus.bkbits.net:8080/linux-2.5/cset@1.1410
> > > 
> > > This URL appears wrong!
> > 
> > Nahh, that's just the same old annoying bkbits bug.  Try with lynx...
> 
> I did - it references a changeset unrelayed to kmalloc

I know, sorry.  The version numbers in BK are not stable, they can't be.
You have to use the underlying internal version number.  If someone who
knows can show me the output of 

	bk changes -r<correct rev>

for that changeset I will figure out a way to have a URL that doesn't change
and send it to Dave for that doc as well as post it there.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
