Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282266AbRKWWfT>; Fri, 23 Nov 2001 17:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282270AbRKWWfL>; Fri, 23 Nov 2001 17:35:11 -0500
Received: from [212.18.232.186] ([212.18.232.186]:40965 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282266AbRKWWex>; Fri, 23 Nov 2001 17:34:53 -0500
Date: Fri, 23 Nov 2001 22:34:12 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH][CFT] Re: 2.4.15-pre9 breakage (inode.c)
Message-ID: <20011123223412.B3141@flint.arm.linux.org.uk>
In-Reply-To: <Pine.GSO.4.21.0111231634310.2422-100000@weyl.math.psu.edu> <Pine.GSO.4.21.0111231701440.2422-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0111231701440.2422-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Nov 23, 2001 at 05:06:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 05:06:46PM -0500, Alexander Viro wrote:
> On Fri, 23 Nov 2001, Alexander Viro wrote:
> > 	Untested fix follows.  And please, pass the brown paperbag... ;-/
> 
> ... and now for something that really builds:

I can confirm this passes my boot, shutdown, reboot test that failed with
2.4.15-greased-turkey.  2.4.15-viro1 is currently running my kernel build
tests quite happily thus far.

I think 2.4.15-greased-turkey should be renamed to 2.4.15-dead-duck. 8)

Al, thanks for the fast response.  Appologies for the slow build.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

