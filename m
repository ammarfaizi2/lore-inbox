Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVAADD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVAADD3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 22:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbVAADD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 22:03:29 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:42221 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262181AbVAADD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 22:03:26 -0500
Date: Fri, 31 Dec 2004 22:03:21 -0500
To: nobody <nobody@andromeda>
Cc: linux lover <linux_lover2004@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: why there is different kernel versions from RedHat?
Message-ID: <20050101030321.GA31952@andromeda>
References: <20041231133525.47475.qmail@web52205.mail.yahoo.com> <41D5FDCE.2090905@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D5FDCE.2090905@tmr.com>
User-Agent: Mutt/1.5.6+20040907i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If 2.6.5 is acceptible:
http://packages.debian.org/unstable/devel/kernel-patch-redhat

Unfortunately, it appears that this package is 'scheduled for
removal'.

Justin

On Fri, Dec 31, 2004 at 08:33:02PM -0500, Bill Davidsen wrote:
> linux lover wrote:
> >Hi all,
> >Where can i get special pathces used by RedHat to
> >original kernels from www.kernel.org?
> 
> Three step process
> 1 - get the RH source RPM and unpack
> 2 - get the kernel.org source of the same number
> 3 - use diff to generate the patch.
