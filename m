Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265442AbSJSBKw>; Fri, 18 Oct 2002 21:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265443AbSJSBKw>; Fri, 18 Oct 2002 21:10:52 -0400
Received: from fmr02.intel.com ([192.55.52.25]:55751 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S265442AbSJSBKu>; Fri, 18 Oct 2002 21:10:50 -0400
Message-ID: <F2DBA543B89AD51184B600508B68D4000E6ADE6E@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: RE: [PATCH] fixes for building kernel using Intel compiler
Date: Fri, 18 Oct 2002 18:16:48 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The one we used was 7.0, and it will be available late November or early
December. It's not 6.0 version, which requires more changes.

Looks like I need to resend another patch.

Thanks,
Jun

-----Original Message-----
From: Greg KH [mailto:greg@kroah.com]
Sent: Friday, October 18, 2002 5:08 PM
To: Nakajima, Jun
Cc: Linus Torvalds; Linux Kernel Mailing List; Mallick, Asit K; Saxena,
Sunil
Subject: Re: [PATCH] fixes for building kernel using Intel compiler


On Fri, Oct 18, 2002 at 04:48:34PM -0700, Nakajima, Jun wrote:
> Hi Linus,
> 
> Attached is the patch that resolves some of the redundant code and casting
> that are required to build the Linux kernel usning Intel compiler. We
would
> like to get this patch incorporated to allow the kernel built with Intel
> Compiler.

The patch is wrapped, and can't apply.

And what version of the Intel compiler is this for?  I tried to get a
previous version to build a kernel, but I had to change a lot more
things than you did (like build flags, etc.)

thanks,

greg k-h
