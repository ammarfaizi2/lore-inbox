Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268691AbRHYLBR>; Sat, 25 Aug 2001 07:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268702AbRHYLA6>; Sat, 25 Aug 2001 07:00:58 -0400
Received: from mail.intrex.net ([209.42.192.246]:13061 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S268691AbRHYLAt>;
	Sat, 25 Aug 2001 07:00:49 -0400
Date: Sat, 25 Aug 2001 07:01:17 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Strange login problems with recent -ac kernels
Message-ID: <20010825070117.A8826@bessie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
    Recently when I login to the first virtual console, I will sometimes get
a message like this:

    bessie login: jlnance
    Last login: Fri Aug 24 12:37:18 from hazard
    Warning: no access to tty (Inappropriate ioctl for device).
    Thus no job control in this shell.

The only thing that has changed recently has been the kernels, so I assume
that it has something to do with them.  Right now I am running 2.4.8-ac9 but
it also happened with -ac7.  I dont remember ever seeing it before that.
It does not happen every time, and it seems to only occur on the ctrl-alt-F1
vitrual console.  Does anyone have any ideas?

Thanks,

Jim
