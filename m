Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbQLGHPd>; Thu, 7 Dec 2000 02:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130111AbQLGHPY>; Thu, 7 Dec 2000 02:15:24 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:29190 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S129627AbQLGHPL>;
	Thu, 7 Dec 2000 02:15:11 -0500
Message-ID: <3A2F3FE7.5CDD0EDA@candelatech.com>
Date: Thu, 07 Dec 2000 00:44:39 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-net <linux-net@vger.kernel.org>
Subject: How to programatically determine if policy-based routing is compiled 
 into the kernel?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a product that is dependent on policy-based (source routing)
and would like to be able to scream loudly at install and startup if
policy-based routing is not enabled in the kernel.

Is there some way to determine this?  Specifically, I'd love
a way to find out through the /proc system, but an ioctl or
similar call would be OK.  I'd even settle for some other tool,
like 'ip', if I could just figure out what commands to tell it.

Thanks,
Ben

-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
