Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSGGTSE>; Sun, 7 Jul 2002 15:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316500AbSGGTSD>; Sun, 7 Jul 2002 15:18:03 -0400
Received: from ns.suse.de ([213.95.15.193]:17931 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316491AbSGGTSC>;
	Sun, 7 Jul 2002 15:18:02 -0400
Date: Sun, 7 Jul 2002 21:20:41 +0200
From: Dave Jones <davej@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Neil Brown <neilb@cse.unsw.edu.au>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] raid kdev_t cleanups (part 1)
Message-ID: <20020707212041.A20087@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alexander Viro <viro@math.psu.edu>,
	Neil Brown <neilb@cse.unsw.edu.au>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
References: <15653.9247.110730.4440@notabene.cse.unsw.edu.au> <Pine.GSO.4.21.0207050151060.14718-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0207050151060.14718-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Jul 05, 2002 at 01:56:38AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2002 at 01:56:38AM -0400, Alexander Viro wrote:

 > Now, if some brave soul would sanitize the horrors
 > in lvm*.c... (hint, hint)

With LVM2 waiting in the wings, is it worth doing the substantial
amount of work needed to get it into decent shape ?
As long as the lvm2 folks can get their act together before
the freeze (which seems quite likely if the rumours about the
new lvm code are true), it may be better for those wanting to
hack on LVM to help out on getting LVM2 into a mergable state.

Comments ?

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
