Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270168AbRIEDvj>; Tue, 4 Sep 2001 23:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270174AbRIEDv3>; Tue, 4 Sep 2001 23:51:29 -0400
Received: from rj.SGI.COM ([204.94.215.100]:62366 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S270168AbRIEDvQ>;
	Tue, 4 Sep 2001 23:51:16 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "David Schwartz" <davids@webmaster.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac6 
In-Reply-To: Your message of "Tue, 04 Sep 2001 20:30:42 MST."
             <NOEJJDACGOHCKNCOGFOMAEAPDLAA.davids@webmaster.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 05 Sep 2001 13:50:46 +1000
Message-ID: <17870.999661846@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2001 20:30:42 -0700, 
"David Schwartz" <davids@webmaster.com> wrote:
>	That really doesn't make sense. Nothing changes in the kernel or the module
>based upon whether you have the source or not. What should logically taint
>the kernel are modules that weren't compiled for that exact kernel version
>or are otherwise mismatched.

Bug reports when binary only modules have been loaded do not belong on
l-k, they have to go to the supplier.  AC wants to identify bug reports
that we can look at and ignore the ones that we cannot sensibly
investigate.  Any proprietary module loaded, at any time, means that
the bug report will almost certainly be ignored.

