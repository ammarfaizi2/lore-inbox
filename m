Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135672AbRDSUKT>; Thu, 19 Apr 2001 16:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135607AbRDSUKF>; Thu, 19 Apr 2001 16:10:05 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:55744 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135603AbRDSUJu>;
	Thu, 19 Apr 2001 16:09:50 -0400
Message-ID: <3ADF45FC.EE7B2003@mandrakesoft.com>
Date: Thu, 19 Apr 2001 16:09:32 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: AJ Lewis <lewis@sistina.com>
Cc: linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
        linux-openlvm@nl.linux.org
Subject: Re: [linux-lvm] Re: [repost] Announce: Linux-OpenLVM mailing list
In-Reply-To: <20010419142400.E10345@sistina.com> <200104191945.f3JJjKRn015661@webber.adilger.int> <20010419145337.K10345@sistina.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AJ Lewis wrote:
> Ok, the issue here is that we're trying to get a release out and so anything
> that majorly changes the code is getting shunted aside for the moment.  It
> would be stupid to just add everything that comes in on the ML without
> review.  Linus does the exact same thing.  I've said this before to you
> Andreas, but apparently you feel that you should have final say on whether
> your patches go in or not.

> As far as getting patches into the stock kernel, we've been sending patches
> to Linus for over a month now, and none of them have made it in.  Maybe
> someone has some pointers on how we get our code past his filters.

Read Documentation/SubmittingPatches, and also listen to kernel hackers
who know the block layer and want to fix lvm.

And I wonder, if kernel hackers are saying lvm is broken... why do you
want to freeze it and ship it in that state?

-- 
Jeff Garzik       | "The universe is like a safe to which there is a
Building 1024     |  combination -- but the combination is locked up
MandrakeSoft      |  in the safe."    -- Peter DeVries
