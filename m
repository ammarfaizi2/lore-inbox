Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268145AbRHJNwH>; Fri, 10 Aug 2001 09:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268149AbRHJNv6>; Fri, 10 Aug 2001 09:51:58 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:21668 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S268145AbRHJNvq>; Fri, 10 Aug 2001 09:51:46 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200108101351.PAA13823@sunrise.pg.gda.pl>
Subject: Re: CONFIG_BLK_DEV_IDEDISK_IBM
To: hk@innoweb.no (Hans K. Rosbach)
Date: Fri, 10 Aug 2001 15:51:10 +0200 (MET DST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <022d01c12197$6f7d8580$d2c0ecd5@dead2> from "Hans K. Rosbach" at Aug 10, 2001 02:24:43 PM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hans K. Rosbach wrote:"
> 
> I cannot say I can find the option for
> CONFIG_BLK_DEV_IDEDISK_IBM
> in the menuconfig atleast..  
> (Neither do i find those for maxtor, quantum, fujitsu, ++)
> 
> Anyone care to tell me what this option does, and why it is
> not in the config? Is there any gain by enabling this manually?

Nothing in released patches.

grep is your friend.

Andrzej
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
