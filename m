Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129639AbRBMW4B>; Tue, 13 Feb 2001 17:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129627AbRBMWzw>; Tue, 13 Feb 2001 17:55:52 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:22523 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129496AbRBMWzi>; Tue, 13 Feb 2001 17:55:38 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102132255.f1DMtO027271@webber.adilger.net>
Subject: Re: Stale super_blocks in 2.2
In-Reply-To: <3A89B3FD.62313E6C@egenera.com> from Phil Auld at "Feb 13, 2001
 05:23:57 pm"
To: Phil Auld <pauld@egenera.com>
Date: Tue, 13 Feb 2001 15:55:24 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philip R. Auld writes:
> Since deja was gobbled by google it's hard to do a good search of 
> this list. Can anyone take the time to help me understand the reason
> for this choice? This seems to me to be backwards. When a device is 
> unmounted there should be no cached information.

Try the following for a searchable mailing list:
http://marc.theaimsgroup.com/?l=linux-kernel&r=1&w=4

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
