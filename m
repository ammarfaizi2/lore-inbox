Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161429AbWJZQUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161429AbWJZQUO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 12:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161431AbWJZQUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 12:20:13 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35763 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161429AbWJZQUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 12:20:11 -0400
Subject: Re: Another kernel releated GPL ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: markh@compro.net
Cc: Erik Mouw <erik@harddisk-recovery.com>, dmarkh@cfl.rr.com,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4540CDFE.4000003@compro.net>
References: <4540839C.6010302@cfl.rr.com>
	 <1161861128.12781.28.camel@localhost.localdomain>
	 <45409BFA.8000507@compro.net>
	 <20061026121041.GB12420@harddisk-recovery.com>
	 <4540B414.7040406@compro.net>
	 <1161872508.12781.42.camel@localhost.localdomain>
	 <4540CDFE.4000003@compro.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 26 Oct 2006 17:17:14 +0100
Message-Id: <1161879434.12781.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-26 am 11:02 -0400, ysgrifennodd Mark Hounschell:
> > In the usual case it doesn't matter, much stuff is GPL anyway, and for
> > the usual system calls/C library stuff not only is the law probably
> > fairly well established but there is an explicit statement with the
> > kernel that we don't want to claim such rights for a normal system call
> > which would guide a Judge if a case ever came up.
> > 
> > 
> 
> That's sort of what I was in search of. Where is this "explicit statement" found
> BTW.

COPYING file in the top directory of the kernel.


   NOTE! This copyright does *not* cover user programs that use kernel
 services by normal system calls - this is merely considered normal use
 of the kernel, and does *not* fall under the heading of "derived work".
 Also note that the GPL below is copyrighted by the Free Software
 Foundation, but the instance of code that it refers to (the Linux
 kernel) is copyrighted by me and others who actually wrote it.

 Also note that the only valid version of the GPL as far as the kernel
 is concerned is _this_ particular version of the license (ie v2, not
 v2.2 or v3.x or whatever), unless explicitly otherwise stated.

                        Linus Torvalds


