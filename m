Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136421AbRD3AZz>; Sun, 29 Apr 2001 20:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136419AbRD3AZp>; Sun, 29 Apr 2001 20:25:45 -0400
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:41223 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S136417AbRD3AZe>;
	Sun, 29 Apr 2001 20:25:34 -0400
Date: Mon, 30 Apr 2001 02:24:55 +0200
From: Frank de Lange <frank@unternet.org>
To: "David S. Miller" <davem@redhat.com>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: Severe trashing in 2.4.4
Message-ID: <20010430022455.A17694@unternet.org>
In-Reply-To: <20010429181809.A10479@unternet.org> <200104291911.XAA04489@ms2.inr.ac.ru> <20010429214853.G11681@unternet.org> <15084.42876.515254.47471@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15084.42876.515254.47471@pizda.ninka.net>; from davem@redhat.com on Sun, Apr 29, 2001 at 04:45:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2001 at 04:45:00PM -0700, David S. Miller wrote:
> 
> Frank de Lange writes:
>  > What do you want me to check for? /proc/net/netstat is a rather busy place...
> 
> Just show us the contents after you reproduce the problem.
> We just want to see if a certain event if being triggered.

Hm, 'twould be nice to know WHAT to look for (if only for educational
purposes), but ok:

 http://www.unternet.org/~frank/projects/linux2404/2404-meminfo/

it contains an extra set of files, named p_n_netstat.*. Same as before, the
.diff contains one-second interval diffs.

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
