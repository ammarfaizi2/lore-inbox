Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284691AbRLPQlW>; Sun, 16 Dec 2001 11:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284710AbRLPQlM>; Sun, 16 Dec 2001 11:41:12 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:53714 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S284691AbRLPQlA>;
	Sun, 16 Dec 2001 11:41:00 -0500
Date: Sun, 16 Dec 2001 17:40:46 +0100
From: David Weinehall <tao@acc.umu.se>
To: David Relson <relson@osagesoftware.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-rc1
Message-ID: <20011216174046.F5235@khan.acc.umu.se>
In-Reply-To: <4.3.2.7.2.20011216103506.00d94b90@mail.osagesoftware.com> <Pine.LNX.4.20.0112160810060.7801-100000@otter.mbay.net> <4.3.2.7.2.20011216111939.00e1eed0@mail.osagesoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <4.3.2.7.2.20011216111939.00e1eed0@mail.osagesoftware.com>; from relson@osagesoftware.com on Sun, Dec 16, 2001 at 11:22:53AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2001 at 11:22:53AM -0500, David Relson wrote:
> At 11:10 AM 12/16/01, John Alvord wrote:
> >You shouldn't fix every single defect, just the ones with wide
> >impact. Otherwise the rcX series could go on a long time. john
> 
> John,
> 
> Well said.  Fix the show stoppers in the rcX series for 2.4.17.  Leave the 
> small ones for 2.4.18-preX.
> 
> ... repeat above steps for 2.4.18-rcX and 2.4.19
> ... repeat for ...
> 
> ... iterate until time for 2.6.0 :-)

Uhm, hopefully the release of 2.6.0 won't mean that maintainance of
2.4.xx will cease. While it *might* be possible that 2.4.xx is bugfree
enough, some smaller fixes and driver-backports will probably still
be needed.


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
