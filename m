Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132389AbRBRBPj>; Sat, 17 Feb 2001 20:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132399AbRBRBP3>; Sat, 17 Feb 2001 20:15:29 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:49162 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S132389AbRBRBPO>;
	Sat, 17 Feb 2001 20:15:14 -0500
Date: Sun, 18 Feb 2001 02:15:08 +0100
From: Frank de Lange <frank@unternet.org>
To: linux-kernel@vger.kernel.org
Cc: reiser@namesys.com, mason@suse.com
Subject: Re: reiserfs on 2.4.1,2.4.2-pre (with null bytes patch) breaks mozilla compile
Message-ID: <20010218021508.B13823@unternet.org>
In-Reply-To: <20010218015715.A13043@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010218015715.A13043@unternet.org>; from frank@unternet.org on Sun, Feb 18, 2001 at 01:57:15AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18, 2001 at 01:57:15AM +0100, Frank de Lange wrote:
> I will retry this with 'all warnings and bells and whistles' turned on in
> reiserfs (on 2.4.1-ac18), and see if anything out of the ordinary is logged. I
> somehow doubt it, since repeated forced reiserfsck's have turned up nothing at
> all...

I just ran the compile again on the described build, same results, no warnings
of any kind, nothing in the debug log facility, nothing on the console...

Reiserfs seems to believe it did the right thing. I'm here to tell you that it
didn't...

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
