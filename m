Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135641AbRD1VOS>; Sat, 28 Apr 2001 17:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135644AbRD1VOI>; Sat, 28 Apr 2001 17:14:08 -0400
Received: from ohiper1-37.apex.net ([209.250.47.52]:12036 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S135641AbRD1VNu>; Sat, 28 Apr 2001 17:13:50 -0400
Date: Sat, 28 Apr 2001 16:13:23 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Lee Mitchell <lee@spamtastic.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 Sound corruption
Message-ID: <20010428161323.A593@hapablap.dyn.dhs.org>
In-Reply-To: <006901c0cfc8$982452a0$0a01a8c0@spamtastic.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <006901c0cfc8$982452a0$0a01a8c0@spamtastic.demon.co.uk>; from lee@spamtastic.demon.co.uk on Sat, Apr 28, 2001 at 10:50:01AM +0100
X-Uptime: 4:07pm  up 15 min,  1 user,  load average: 1.75, 1.94, 1.26
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm also seeing what would appear to be exactly this.

The problem, for me, doesn't occur when I write directly to /dev/dsp
(i.e., use the OSS output plugin for xmms).  The problem only occurs
with esd.

It would appear that something in the kernel broke esd.

On Sat, Apr 28, 2001 at 10:50:01AM +0100, Lee Mitchell wrote:
> Problem..
> Playing mp3's under 2.4.4 (SMP) results in bursts of noise overlayed on top
> of actual music being played.
> Works fine running 2.4.3 (SMP)

Running UP here

PCChips M599LMR
1 x AMD-K6/2 500MHz
128MB RAM
C-Media
Kernel 2.4.4
Debian 2.2
gcc version 2.95.2 20000220 (Debian GNU/Linux)
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
