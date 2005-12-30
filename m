Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbVL3Cf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVL3Cf1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 21:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVL3Cf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 21:35:27 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:37590 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1750769AbVL3Cf1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 21:35:27 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Fri, 30 Dec 2005 03:35:16 +0100
Subject: Re: userspace breakage
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Ryan Anderson <ryan@michonline.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-reply-to: <20051230021432.GA20371@redhat.com>
References: <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com> <43B48176.3080509@michonline.com> <20051230004608.GA12822@redhat.com> <Pine.LNX.4.64.0512291702140.3298@g5.osdl.org> <20051230012145.GD12822@redhat.com> <43B49715.9010809@liberouter.org> <20051230021432.GA20371@redhat.com>
Message-Id: <20051230023515.24B5D1D3647@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Fri, Dec 30, 2005 at 03:10:29AM +0100, Jiri Slaby wrote:
> 
>  > http://download.fedora.redhat.com/pub/fedora/linux/core/development/SRPMS/
>  > [maybe this is the difference?
> 
> Of course. development branch always has latest userspace.
> The point here is that the old userspace breaks.
OK, I am with you, but when I am trying (devel) -rc releases, I need devel pkgs
(my opinion). And there is some time then to move these devel pkgs to release
database until next not-rc become real. Indeed, changes like this in some -rc
just before stable release or BIG changes in -rc at all are crazy, but if
somebody do that, we all have the chance say "STOP, we don't want it" (that's
the one from points to get lkml) not only THE MAN before git-commit.

regards,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
