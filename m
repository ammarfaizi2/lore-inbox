Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317448AbSF1Oyk>; Fri, 28 Jun 2002 10:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317450AbSF1Oyj>; Fri, 28 Jun 2002 10:54:39 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:10219 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S317448AbSF1Oyi>;
	Fri, 28 Jun 2002 10:54:38 -0400
Date: Sat, 29 Jun 2002 00:53:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lars Duesing <ld@stud.fh-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI / APM - Battery level not readable on HP Omnibook XE3 (again)
Message-Id: <20020629005357.35fc14b1.sfr@canb.auug.org.au>
In-Reply-To: <1025164995.25831.6.camel@ws1.intern.stud.fh-muenchen.de>
References: <1025164995.25831.6.camel@ws1.intern.stud.fh-muenchen.de>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars,

On 27 Jun 2002 10:03:11 +0200 Lars Duesing <ld@stud.fh-muenchen.de> wrote:
>
> I sent a question regarding this in early December.
> ( http://www.cs.helsinki.fi/linux/linux-kernel/2001-48/0691.html )
> Since then I got many questions whether this is already fixed or not.
> Latest 2.4-Kernel is still not fixed. 
> 
> Is there so much trouble in this?

As far as APM is concerned this is not fixable in the kernel as the BIOS
appears to have a bug.  Please see if your vendor has an updated BIOS.

The ACPI guys may be able to tell you how to work around this, but maybe
not.  Again it is a bug in the BIOS.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
