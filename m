Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129574AbRBSRlo>; Mon, 19 Feb 2001 12:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129696AbRBSRle>; Mon, 19 Feb 2001 12:41:34 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:42512 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S129574AbRBSRlY>;
	Mon, 19 Feb 2001 12:41:24 -0500
Date: Mon, 19 Feb 2001 18:40:30 +0100
From: Frank de Lange <frank@unternet.org>
To: David <david@kalifornia.com>
Cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
        reiser@namesys.com
Subject: Re: reiserfs on 2.4.1,2.4.2-pre (with null bytes patch) breaks mozilla compile
Message-ID: <20010219184030.B13482@unternet.org>
In-Reply-To: <1217040000.982455419@tiny> <3A8F29C5.7000302@kalifornia.com> <20010218030727.C13823@unternet.org> <3A8F3106.6020107@kalifornia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A8F3106.6020107@kalifornia.com>; from david@kalifornia.com on Sat, Feb 17, 2001 at 06:18:46PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2001 at 06:18:46PM -0800, David wrote:
> > Well, I run glibc-2.2.1 as well, so that might be one of the factors
> > contributing to this. Then again, glibc-2.2.1 with ext2 does not cause any
> > problems whatsoever with mozilla. So it could be that reiserfs + glibc-2.2.1 is
> > a bad combination, question remains which of these two is the culprit (if not
> > both). Since glibc-2.2.2 is out, I will give that a try as well. Not tonight
> > though...

FYI

I'm running glibc-2.2.2 now, and alas... Mozilla still refuses to be compiled,
no change...

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
