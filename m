Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131349AbRCHNTA>; Thu, 8 Mar 2001 08:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131351AbRCHNSu>; Thu, 8 Mar 2001 08:18:50 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:40686 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S131349AbRCHNSn>; Thu, 8 Mar 2001 08:18:43 -0500
Date: Thu, 8 Mar 2001 14:18:19 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 64-bit capable block device layer
Message-ID: <20010308141819.Q27675@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010307184749.A4653@suse.de> <Pine.LNX.4.33.0103071504250.1409-100000@duckman.distro.conectiva> <20010307195323.D4653@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010307195323.D4653@suse.de>; from axboe@suse.de on Wed, Mar 07, 2001 at 07:53:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2001 at 07:53:23PM +0100, Jens Axboe wrote:
> Plus compile time options are nasty :-). It would probably make
> bigger sense to completely skip all the merging etc for low end
> machines. I think they already do this for embedded kernels (ie
> removing ll_rw_blk.c and elevator.c). That avoids most of the
> 64-bit arithmetic anyway.

Do you know of any patches to do so?

Thanks and regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
