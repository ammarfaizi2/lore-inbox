Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265222AbTABQoc>; Thu, 2 Jan 2003 11:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265236AbTABQoc>; Thu, 2 Jan 2003 11:44:32 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:3222 "HELO atlrel9.hp.com")
	by vger.kernel.org with SMTP id <S265222AbTABQoa>;
	Thu, 2 Jan 2003 11:44:30 -0500
Message-ID: <3E146E6B.8CCA954E@hp.com>
Date: Thu, 02 Jan 2003 09:52:59 -0700
From: Khalid Aziz <khalid_aziz@hp.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel .config support?
References: <Pine.LNX.4.44.0301021141210.8604-100000@dell>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert P. J. Day" wrote:
> 
> On 2 Jan 2003, Alan Cox wrote:
> 
> >
> > Its never been in the standard 2.4 kernel. The facility has been in the
> > -ac kernel, and was recently submitted for consideration in 2.5
> 
> that's odd.  the selection for kernel .config support has been in
> the red hat config menus for at least the last release, as well
> as the extraction script .../scripts/extract-ikconfig.  but this
> never worked due to a missing "binoffset" utility.  i even filed
> a bugzilla on that (bug 65677).
> 
> just curious -- how did that ever end up in the distributed red hat
> kernel if it was never standard?  strange.
> 

Redhat kernel is not the same as standard kernel (the official one, on
kernel.org). Redhat adds a number of patches to the standard kernel
before releasing it.

-- 
Khalid

====================================================================
Khalid Aziz                                Linux and Open Source Lab
(970)898-9214                                        Hewlett-Packard
khalid@hp.com                                       Fort Collins, CO

"The Linux kernel is subject to relentless development" 
				- Alessandro Rubini
