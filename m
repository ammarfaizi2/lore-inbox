Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270595AbRHIVb3>; Thu, 9 Aug 2001 17:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269866AbRHIVbT>; Thu, 9 Aug 2001 17:31:19 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:45305 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S270595AbRHIVbD>; Thu, 9 Aug 2001 17:31:03 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108092131.f79LV4Hr024656@webber.adilger.int>
Subject: Re: using bug reports on vendor kernels
In-Reply-To: <01080923020201.04501@idun> "from Oliver Neukum at Aug 9, 2001 11:02:02
 pm"
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
Date: Thu, 9 Aug 2001 15:31:04 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver writes:
> is there a site that would allow me to browse a list of patches added to 
> vendor kernels (esp. RedHat). I need this to use an oops supplied by a user.

You _should_ be able to simply get the RedHat source RPM, and have a look
at the various patches that are applied to the base Linus kernel.  At least
that is how the Turbolinux and SuSE kernels are built (haven't looked
at a RedHat kernel in a while, but I expect the same).  Granted, some
of the patch names are not exactly self explanitory (e.g. jumbo patches
like -ac or -aa, which have their own documentation somewhere, often l-k).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

