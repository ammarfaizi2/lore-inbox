Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262777AbVDHJq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbVDHJq7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 05:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbVDHJq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 05:46:59 -0400
Received: from cmailg1.svr.pol.co.uk ([195.92.195.171]:60685 "EHLO
	cmailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S262777AbVDHJqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 05:46:52 -0400
Message-Id: <200504080946.j389kbH09946@blake.inputplus.co.uk>
To: Humberto Massa <humberto.massa@almg.gov.br>
cc: David Schmitt <david@black.co.at>, debian-kernel@lists.debian.org,
       debian-legal@lists.debian.org, linux-kernel@vger.kernel.org,
       linux-acenic@sunsite.dk
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice. 
In-Reply-To: <4255278E.4000303@almg.gov.br> 
Date: Fri, 08 Apr 2005 10:46:37 +0100
From: Ralph Corderoy <ralph@inputplus.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Humberto Massa wrote:
> First, there is *NOT* any requirement in the GPL at all that requires
> making compilers available. Otherwise it would not be possible, for
> instance, have a Visual Basic GPL'd application. And yes, it is
> possible.

>From section 3 of the GNU GPL, version 2:

    The source code for a work means the preferred form of the work for
    making modifications to it.  For an executable work, complete source
    code means all the source code for all modules it contains, plus any
    associated interface definition files, plus the scripts used to
    control compilation and installation of the executable.  However, as a
    special exception, the source code distributed need not include
    anything that is normally distributed (in either source or binary
    form) with the major components (compiler, kernel, and so on) of the
    operating system on which the executable runs, unless that component
    itself accompanies the executable.

I take that to mean the compiler's exempted if it's the normal one
available on the platform, but if the software distributor had to modify
gcc to produce the binaries it's distributing then you're entitled to
the compiler too.

So a Visual BASIC application uses a standard VB compiler, but that's
not necessarily the case for a Linux kernel running on an embedded box.

Cheers,


Ralph.

