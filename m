Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132619AbRDOKKW>; Sun, 15 Apr 2001 06:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132620AbRDOKKM>; Sun, 15 Apr 2001 06:10:12 -0400
Received: from adsl-213-254-163-44.mistral-uk.net ([213.254.163.44]:24334 "EHLO
	crucigera.fysh.org") by vger.kernel.org with ESMTP
	id <S132619AbRDOKJ5>; Sun, 15 Apr 2001 06:09:57 -0400
Date: Sun, 15 Apr 2001 11:09:55 +0100
From: Athanasius <Athanasius@miggy.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Process (mozilla) in 'D' state (down_w)
Message-ID: <20010415110955.A21319@miggy.org>
Mail-Followup-To: Athanasius <Athanasius@miggy.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010413075244.A733@miggy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010413075244.A733@miggy.org>; from Athanasius@miggy.org on Fri, Apr 13, 2001 at 07:52:44AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2001 at 07:52:44AM +0100, Athanasius wrote:
>    Seems like anytime I first startup mozilla I end up with something
> like:
[snip]
>    I'll sometime if I can remember to run mozilla with a strace -f -ff
> -o file to see if it gives any more useful info.  I'll be updating to
> 2.4.3-ac5 in the next hour or so anyway (currently on plain vanilla
> 2.4.3).

   Ok, this seems to be gone in 2.4.3-ac5.  Three reboots, first two I
ran mozilla as strace -f -ff -o mozilla-strace mozilla and got no
D-state process, this third one I just ran it as normal from my fvwm2
menus and it's also working fine.

-Ath
-- 
- Athanasius = Athanasius(at)miggy.org / http://www.miggy.org/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME
