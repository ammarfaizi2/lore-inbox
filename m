Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265412AbSJSADO>; Fri, 18 Oct 2002 20:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265414AbSJSADO>; Fri, 18 Oct 2002 20:03:14 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:9234 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265412AbSJSAC4>;
	Fri, 18 Oct 2002 20:02:56 -0400
Date: Fri, 18 Oct 2002 17:08:25 -0700
From: Greg KH <greg@kroah.com>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH] fixes for building kernel using Intel compiler
Message-ID: <20021019000825.GD11924@kroah.com>
References: <F2DBA543B89AD51184B600508B68D4000E6ADE5B@fmsmsx103.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000E6ADE5B@fmsmsx103.fm.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 04:48:34PM -0700, Nakajima, Jun wrote:
> Hi Linus,
> 
> Attached is the patch that resolves some of the redundant code and casting
> that are required to build the Linux kernel usning Intel compiler. We would
> like to get this patch incorporated to allow the kernel built with Intel
> Compiler.

The patch is wrapped, and can't apply.

And what version of the Intel compiler is this for?  I tried to get a
previous version to build a kernel, but I had to change a lot more
things than you did (like build flags, etc.)

thanks,

greg k-h
