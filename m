Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311829AbSCNWOy>; Thu, 14 Mar 2002 17:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311830AbSCNWOn>; Thu, 14 Mar 2002 17:14:43 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:56988 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S311829AbSCNWOc>;
	Thu, 14 Mar 2002 17:14:32 -0500
Message-ID: <3C9120C7.4020709@candelatech.com>
Date: Thu, 14 Mar 2002 15:14:31 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: compile problem in bk://linux24.bkbits.net/linux-2.4 repository.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By the way, should I even be reporting such errors, and if so,
is this the right place to report them?

make -C aic7xxx modules
make[3]: Entering directory `/home/greear/kernel/2.4/bk/linux-2.4/drivers/scsi/aic7xxx'
make[3]: *** No rule to make target `aic7xxx_linux.o', needed by `aic7xxx_mod.o'.  Stop.
make[3]: Leaving directory `/home/greear/kernel/2.4/bk/linux-2.4/drivers/scsi/aic7xxx'
make[2]: *** [_modsubdir_aic7xxx] Error 2
make[2]: Leaving directory `/home/greear/kernel/2.4/bk/linux-2.4/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/home/greear/kernel/2.4/bk/linux-2.4/drivers'
make: *** [_mod_drivers] Error 2

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


