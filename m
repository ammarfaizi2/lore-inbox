Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267638AbSKTHVR>; Wed, 20 Nov 2002 02:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267633AbSKTHUU>; Wed, 20 Nov 2002 02:20:20 -0500
Received: from dp.samba.org ([66.70.73.150]:56787 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267640AbSKTHTt>;
	Wed, 20 Nov 2002 02:19:49 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Alexander Viro <viro@math.psu.edu>,
       Linux Scsi Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Why /dev/sdc1 doesn't show up... 
In-reply-to: Your message of "Tue, 19 Nov 2002 12:55:20 CDT."
             <3DDA7B08.7010101@pobox.com> 
Date: Wed, 20 Nov 2002 08:42:23 +1100
Message-Id: <20021120072654.2C1AD2C085@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DDA7B08.7010101@pobox.com> you write:
> Doug Ledford wrote:
> > are ready for them to be used.  Don't muck with the module loader to 
> > solve
> > the problem, fix the maybe 4 or 5 modules that might violate this rule.
> 
> violently agreed.  This has the potential for requiring an update of 
> almost every driver in the kernel, does it not?

God no!  I'm crazy maybe, but not stupid.  I know of two interfaces
which would be affected, and no drivers.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
