Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264290AbUBHXbE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 18:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbUBHXbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 18:31:04 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:29125
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S264290AbUBHXbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 18:31:02 -0500
Message-ID: <4026C213.4050904@tmr.com>
Date: Sun, 08 Feb 2004 18:11:15 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Meelis Roos <mroos@linux.ee>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-rc1: snd_intel8x0 still too fast
References: <Pine.GSO.4.44.0402071702310.4899-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0402071702310.4899-100000@math.ut.ee>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos wrote:
> I tried 2.6.3-rc1 to see if the problems with intel 8x0 audio are fixed.
> Nope, the sound is still at least twice as fast as normal. KDE login
> sound, mplayer sound etc. This is I815 integrated audio on Intel
> D815EEA2 mainboard, Debian unstable up-to-date. 2.4.latest kernel with
> OSS is OK. 2.6 with ALSA was OK at about 2.6.0. 2.6 with OSS is also OK.
> 
> Also, I can load both i810_audio and snd_intel8x0 simultaneously in 2.6
> - probably a resource management problem.

Odd, I only have the problem with xmms, mplayer works fine.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
