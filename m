Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281814AbRKWXGm>; Fri, 23 Nov 2001 18:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282096AbRKWXGd>; Fri, 23 Nov 2001 18:06:33 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:5110 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281814AbRKWXGY>;
	Fri, 23 Nov 2001 18:06:24 -0500
Date: Fri, 23 Nov 2001 16:05:36 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH][CFT] Re: 2.4.15-pre9 breakage (inode.c)
Message-ID: <20011123160536.D1308@lynx.no>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <Pine.GSO.4.21.0111231634310.2422-100000@weyl.math.psu.edu> <Pine.GSO.4.21.0111231701440.2422-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.GSO.4.21.0111231701440.2422-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Nov 23, 2001 at 05:06:46PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 23, 2001  17:06 -0500, Alexander Viro wrote:
> On Fri, 23 Nov 2001, Alexander Viro wrote:
> > 	Untested fix follows.  And please, pass the brown paperbag... ;-/
> 
> ... and now for something that really builds:

Hey, this gives Linus a good reason to make another 2.4.15 release,
and silence all of the people complaining about -greased-turkey (which,
as we all know, was Linus' prerelease for testing that everything was
working OK before he made an _official_ 2.4.15 release, and a good thing
he did or this bug wouldn't have shown up until the _official_ 2.4.15
release which would have been embarassing ;-).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

