Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbTJNLE0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 07:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbTJNLE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 07:04:26 -0400
Received: from users.linvision.com ([62.58.92.114]:41114 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262377AbTJNLEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 07:04:23 -0400
Date: Tue, 14 Oct 2003 13:04:13 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Karel Kulhav? <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make htmldocs
Message-ID: <20031014110413.GC15075@bitwizard.nl>
References: <20031013185539.B1832@beton.cybernet.src> <20031014094601.GB15075@bitwizard.nl> <20031014120946.A4969@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031014120946.A4969@beton.cybernet.src>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 12:09:46PM +0200, Karel Kulhav? wrote:
> > > 2) How do I install DocBook stylesheets?
> > 
> > Depends on distribution.
> 
> How do I determine what distribution I have? I have compiled my whole system
> manually.

Not the problem of the kernel. If you can build your whole system
manually, you also know how to use Google.

> Asking again: how do I install "DocBook stylesheets"?

Replying again: Depends on distribution. (On Debian: apt-get install
docbook docbook-dsssl).

> Do you say that the place where DocBook stylesheet sources can be downloaded
> depends on distribution I have? I have been looking at their sourceforge
> project page but there is nothing like "download DocBook stylesheets".
> There are DocBook-dsssl and a ton of other cryptic packages but none of them
> is stylesheets.

Distributions tend to package these kind of projects. DocBook is one of
the projects that has been packaged by the distributions. GCC is
another project.

> If there doesn't exist any distribution-idependent installation process
> for "DocBook stylesheets", then "DocBook stylesheets" is not portable,
> and transitively, "Linux Kernel" is not portable. Could you please
> recommend me some other open-source free operating system where I don't
> need to have a "distribution" to be even able to read it's enclosed
> documentation? I have been using Linux Kernel for 7 years but can't anymore
> because I am unable to read it's manual.

DocBook is not necessary to *build* the kernel. It's only used to make
nicely formatted documents from the comments already in the kernel
source or to make nicely formatted documents from the source of the
books in Documentation/DocBook/. If you don't have DocBook available,
that doesn't make the kernel less portable, all documentation is
available in a human readable format.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
| Data lost? Stay calm and contact Harddisk-recovery.com
