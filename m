Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268447AbTBNP72>; Fri, 14 Feb 2003 10:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267200AbTBNP72>; Fri, 14 Feb 2003 10:59:28 -0500
Received: from bitmover.com ([192.132.92.2]:49064 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267199AbTBNP7Z>;
	Fri, 14 Feb 2003 10:59:25 -0500
Date: Fri, 14 Feb 2003 08:09:15 -0800
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, David Dillow <dillowd@y12.doe.gov>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 3Com 3cr990 driver release
Message-ID: <20030214160915.GC3188@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
	David Dillow <dillowd@y12.doe.gov>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
References: <3E4C9FAA.FC8A2DC7@y12.doe.gov> <1045233209.7958.11.camel@irongate.swansea.linux.org.uk> <20030214151920.GA3188@work.bitmover.com> <1045241640.1353.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045241640.1353.13.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 04:54:01PM +0000, Alan Cox wrote:
> On Fri, 2003-02-14 at 15:19, Larry McVoy wrote:
> > > Would you care to make the patches available in a format those of us who
> > > work on open source version control systems can use. Right now Mr McVoy
> > > prohibits me from reviewing your patches.
> > 
> > That seems a bit extreme, Alan.  I don't recall prohibiting you from anything
> > of the kind.
> 
> Since I work for a company who works on competing version control products I'm
> not allowed to use bitkeeper. Since his patches are only in bitkeeper format
> I can't read them.

Sure you can, unless your objection extends to getting at data which is in
BK over the web.  http://typhoon.bkbits.net:8080/typhoon-2.4/patch@+

And you have options beyond that.  Perhaps it has escaped your notice that
Dave M and others who are also employed by Red Hat are (happily?) using
BK and we haven't kicked up a fuss.

I tend to doubt that you really want to use BK, you seem to have strong
feelings about it, but if you do and you want to be sure that you can,
that's an easily solved problem.  And if you don't want to be special
cased, which is understandable, then you can have a manager from Red Hat
talk to me and we'll work it out just like we're working it out with other
companies.

That goes for any other kernel developer who feels that they are in
a gray area.  No, we're not going to make an exception if you are 
actively contributing to a different SCM system, that's where we draw
the line.  But the license cast a wide net by saying "you or anyone in
your company" so we're willing to work out.  The goal is to support 
kernel development, and there is another unfortunate constraint of 
not shooting ourselves in the foot.  As long as we can do both, we 
will.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
