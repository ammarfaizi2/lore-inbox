Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261680AbREOWq6>; Tue, 15 May 2001 18:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261681AbREOWqs>; Tue, 15 May 2001 18:46:48 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:8701 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261680AbREOWqd>; Tue, 15 May 2001 18:46:33 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200105152245.f4FMjnwN021983@webber.adilger.int>
Subject: Re: Exporting symbols from a module.
In-Reply-To: <3B01AC4E.8020805@fugmann.dhs.org> "from Anders Peter Fugmann at
 May 16, 2001 00:23:10 am"
To: Anders Peter Fugmann <afu@fugmann.dhs.org>
Date: Tue, 15 May 2001 16:45:49 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Fugmann writes:
> I'm not sure where to put this in my Makefile.
> (tried, but it did not help)
> Could you please send an example.

See fs/Makefile or fs/msdos/Makefile for examples.  I assume you are
building your module under the kernel tree?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
