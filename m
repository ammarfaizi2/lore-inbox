Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbTBPQ61>; Sun, 16 Feb 2003 11:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267270AbTBPQ61>; Sun, 16 Feb 2003 11:58:27 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:9844
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267241AbTBPQ60>; Sun, 16 Feb 2003 11:58:26 -0500
Date: Sun, 16 Feb 2003 12:06:43 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Rahul Vaidya <rahulv@csa.iisc.ernet.in>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.53 not compiling 
In-Reply-To: <Pine.LNX.4.44.0302162227200.18137-100000@topaz.csa.iisc.ernet.in>
Message-ID: <Pine.LNX.4.50.0302161205240.578-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0302162227200.18137-100000@topaz.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Feb 2003, Rahul Vaidya wrote:

> When I tried to "make bzImage" the 2.5.53 it gave me the following error
> 
> In file included from include/linux/spinlock.h:13,
>                  from include/linux/mmzone.h:8,
>                  from include/linux/gfp.h:4,
>                  from include/linux/slab.h:14,
>                  from include/linux/proc_fs.h:5,
>                  from init/main.c:15:
> include/linux/kernel.h:10:20: stdarg.h: No such file or directory
> 
> I am using gcc-3.2. And I did make menuconfig with default settings.
> 
> Please CC the Reply to my mail-id rahulv@csa.iisc.ernet.in

Could you try updating to 2.5.61, it is available at www.kernel.org with 
mirrors at www.xx.kernel.org where xx is the country code of the mirror.

	Zwane
-- 
function.linuxpower.ca
