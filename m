Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314656AbSD1Bcm>; Sat, 27 Apr 2002 21:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314657AbSD1Bcm>; Sat, 27 Apr 2002 21:32:42 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:9673 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S314656AbSD1Bcl>; Sat, 27 Apr 2002 21:32:41 -0400
Date: Sat, 27 Apr 2002 21:32:36 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Panu Matilainen <pmatilai@welho.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, nfs@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: 1279 mounts
Message-ID: <20020427213236.A20253@devserv.devel.redhat.com>
In-Reply-To: <20020425162106.A30736@devserv.devel.redhat.com> <Pine.LNX.4.44.0204261120520.19032-100000@chip.2y.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Fri, 26 Apr 2002 11:25:33 +0300 (EEST)
> From: Panu Matilainen <pmatilai@welho.com>

> I've got quite a few users here who "need" this functionality and it's 
> included in our RH-based custom kernels. Having it as a separate patch 
> for 2.4 is no problem, for 2.5 I'm hoping we finally move to 32bit device 
> numbers...

Mind, we only ship the unnamed majors part, but not the NFS part.
There is no word from util-linux maintainer about required
changes to mount(8), so I was cautious about doint that.

-- Pete
