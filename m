Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbTJNM5x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 08:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbTJNM5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 08:57:53 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:62336 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S262336AbTJNM5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 08:57:50 -0400
Date: Tue, 14 Oct 2003 14:57:50 +0200
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: Re: make htmldocs
Message-ID: <20031014145750.A5207@beton.cybernet.src>
References: <20031013185539.B1832@beton.cybernet.src> <20031014094601.GB15075@bitwizard.nl> <20031014120946.A4969@beton.cybernet.src> <20031014110413.GC15075@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031014110413.GC15075@bitwizard.nl>; from erik@harddisk-recovery.com on Tue, Oct 14, 2003 at 01:04:13PM +0200
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 01:04:13PM +0200, Erik Mouw wrote:
> On Tue, Oct 14, 2003 at 12:09:46PM +0200, Karel Kulhav? wrote:
> > > > 2) How do I install DocBook stylesheets?
> > > 
> > > Depends on distribution.
> > 
> > How do I determine what distribution I have? I have compiled my whole system
> > manually.
> 
> Not the problem of the kernel. If you can build your whole system
> manually, you also know how to use Google.

I put "install docbook stylesheets" into google and found:

* Norm Walsh's stylesheets for DocBook
* SGML DocBook Stylesheets
* docbook-stylesheets-doc
* docbook-dsssl-stylesheets
* DocBook XSLT stylesheets

Please tell me which of them should I install to get Linux Kernel
docs compiled.

> > Asking again: how do I install "DocBook stylesheets"?
> 
> Replying again: Depends on distribution. (On Debian: apt-get install
> docbook docbook-dsssl).

On http://sourceforge.net/projects/docbook there are:

docbook-dsssl
docbook-dsssl-doc
docbook-testdocs
docbook-xsl
jrefenty
litprog
slides
slides-demo
website
xslt-include-import-test

I can't see neither "docbook" nor "stylesheets". Please tell me which of
them should I use to install "DocBook stylesheets" or "docbook".

> 
> > Do you say that the place where DocBook stylesheet sources can be downloaded
> > depends on distribution I have? I have been looking at their sourceforge
> > project page but there is nothing like "download DocBook stylesheets".
> > There are DocBook-dsssl and a ton of other cryptic packages but none of them
> > is stylesheets.
> 
> Distributions tend to package these kind of projects. DocBook is one of
> the projects that has been packaged by the distributions. GCC is
> another project.

When I install gcc, I don't use any distribution-packaged whatever.
I just:
* download source tarball from GCC homepage
* ./configure
* make
* make install

Have done it already at least twenty times with various versions of gcc and
never needed anything packaged by any distribution.

Cl<
