Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317876AbSHSE1H>; Mon, 19 Aug 2002 00:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317931AbSHSE1H>; Mon, 19 Aug 2002 00:27:07 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:1299 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id <S317876AbSHSE1G>;
	Mon, 19 Aug 2002 00:27:06 -0400
Date: Mon, 19 Aug 2002 06:31:04 +0200
From: Willy Tarreau <willy@w.ods.org>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: make allyesconfig?
Message-ID: <20020819043104.GA25502@alpha.home.local>
References: <3D6017E8.mail17T111BQN@viadomus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D6017E8.mail17T111BQN@viadomus.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2002 at 11:55:52PM +0200, DervishD wrote:
>     Hi all :))
> 
>     I've seen posts here about doing 'make allyesconfig' on 2.4.19,
> but allyesconfig is not on my 2.4.19 tree... AFAIK, the 'allyesconfig'
> target is on 2.5.x branch, am I wrong?

you can download (and apply) kbuild-2.5 for 2.4.19 on sourceforge :
http://sourceforge.net/projects/showfiles.php?group_id=18813

I agree that allyesconfig and allmodconfig are very convenient ways to test
kernels and compilation problems.

Cheers,
Willy
