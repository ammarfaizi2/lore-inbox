Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130015AbRBGTnn>; Wed, 7 Feb 2001 14:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130407AbRBGTnX>; Wed, 7 Feb 2001 14:43:23 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:60420 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129652AbRBGTnM>; Wed, 7 Feb 2001 14:43:12 -0500
Date: Wed, 7 Feb 2001 13:35:15 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: langus@timpanogas.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: PCI-SCI Build Problems on RedHat 7.1
Message-ID: <20010207133515.A28268@vger.timpanogas.org>
In-Reply-To: <20010207131439.A28015@vger.timpanogas.org> <E14QaAX-00016d-00@the-village.bc.nu> <20010207132426.A28159@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010207132426.A28159@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Wed, Feb 07, 2001 at 01:24:26PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2001 at 01:24:26PM -0700, Jeff V. Merkey wrote:

Larry,  

Please provide to Alan Cox the exact versions and revision levels of 
the RedHat 7.1 build used for the SCI testing.  Please provide him 
any other information he requests concerning the setup of this 
system.

Jeff


> On Wed, Feb 07, 2001 at 07:22:19PM +0000, Alan Cox wrote:
> > > In file included from init.c:30:
> > > ../../prolog.h:344:8: invalid #ident
> > 
> > It doesnt say #ident isnt supported it says your use of it is invalid. What
> > precisely does that line read ?
> 
> JJ tried it and it worked on some version he was running, but fails on 
> the 7.1 build.  Here is the code that produces the offending messages.
> I got an "invalid keyword" (sorry, it was not "unknown" but "invalid", that was 
> a different error message on gcc 2.96).
> 
> Jeff
> 
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
