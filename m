Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292819AbSBQHWo>; Sun, 17 Feb 2002 02:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292816AbSBQHWf>; Sun, 17 Feb 2002 02:22:35 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:54917 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S292818AbSBQHWW>; Sun, 17 Feb 2002 02:22:22 -0500
Message-Id: <200202161737.g1GHbkJh001254@tigger.cs.uni-dortmund.de>
To: Michael Sinz <msinz@wgate.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Core dump file control 
In-Reply-To: Message from Michael Sinz <msinz@wgate.com> 
   of "Fri, 15 Feb 2002 12:57:09 EST." <3C6D4BF5.918049D8@wgate.com> 
Date: Sat, 16 Feb 2002 18:37:46 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Sinz <msinz@wgate.com> said:
> I have, for a long time, wished that Linux had a way to specify where
> core dumps are stored

CWD (chdir(2))

>                       and what the name of the core dump is.

/proc/sys/kernel/core_uses_pid
-- 
Horst von Brand			     http://counter.li.org # 22616
