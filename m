Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137199AbREKSV4>; Fri, 11 May 2001 14:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137201AbREKSVq>; Fri, 11 May 2001 14:21:46 -0400
Received: from h55t105.delphi.afb.lu.se ([130.235.188.122]:16900 "EHLO
	cheetah.psv.nu") by vger.kernel.org with ESMTP id <S137199AbREKSVg>;
	Fri, 11 May 2001 14:21:36 -0400
Date: Fri, 11 May 2001 20:21:32 +0200 (CEST)
From: Peter Svensson <petersv@psv.nu>
To: "Brian J. Murrell" <brian@mountainviewdata.com>
cc: <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] ip autoconfig with modules, kernel 2.4
In-Reply-To: <20010511111300.A27378@brian-laptop.us.mvd>
Message-ID: <Pine.LNX.4.33.0105112020530.1655-100000@cheetah.psv.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 May 2001, Brian J. Murrell wrote:

> If there were a way to tell the kernel, from userspace, for
> change_root()/mount_root() where the nfsroot path was, yes.  I have
> been hunting through all of the (nfs) root mount code and I don't see
> it.  It looks like it can be set either on the command line, or by the
> kernel implementation of bootp.  Am I missing it somewhere?

Doesn't the pivot_root do just that in 2.4? Not that I have used it or
anything.

Peter
--
Peter Svensson      ! Pgp key available by finger, fingerprint:
<petersv@psv.nu>    ! 8A E9 20 98 C1 FF 43 E3  07 FD B9 0A 80 72 70 AF
<petersv@df.lth.se> !
------------------------------------------------------------------------
Remember, Luke, your source will be with you... always...


