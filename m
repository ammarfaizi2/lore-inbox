Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292835AbSCDUBu>; Mon, 4 Mar 2002 15:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292836AbSCDUBk>; Mon, 4 Mar 2002 15:01:40 -0500
Received: from ua194d37hel.dial.kolumbus.fi ([62.248.234.194]:64407 "EHLO
	porkkala.uworld.dyndns.org") by vger.kernel.org with ESMTP
	id <S292835AbSCDUBX>; Mon, 4 Mar 2002 15:01:23 -0500
Message-ID: <3C83D27C.99BB636D@kolumbus.fi>
Date: Mon, 04 Mar 2002 22:01:00 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: J Sloan <joe@tmsusa.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: latency & real-time-ness.
In-Reply-To: <E16hd1T-0005QW-00@the-village.bc.nu> <3C82A702.1030803@candelatech.com> <3C82CA19.9000702@tmsusa.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan wrote:
> 
> The full-on low latency patch from Andrew Morton?
> 
> You might want to make some diffs available
> since AFIK that would have involved quite a bit
> of hand editing to fix rejects...

There is also patch against 2.4.18 with following:

 - Latest Andre's IDE driver
 - Latest Lionel's SiS IDE driver
 - Latest Rik's rmap
 - Latest Ingo's O(1)
 - Andrew's full and mini lowlatency
 - My DRM lowlatency fixes (r128, radeon, mga) (in -ll)


Available at http://www.pp.song.fi/~visitor/linux/


 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

