Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312895AbSDSVDt>; Fri, 19 Apr 2002 17:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312898AbSDSVDs>; Fri, 19 Apr 2002 17:03:48 -0400
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:58042 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S312895AbSDSVDr>;
	Fri, 19 Apr 2002 17:03:47 -0400
Message-ID: <3CC08632.8020102@candelatech.com>
Date: Fri, 19 Apr 2002 14:03:46 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: unresolved symbol: __udivdi3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to be able to devide 64bit numbers in a kernel module,
but I get unresolved symbols when trying to insmod.

Does anyone have any ideas how to get around this little issue
(without the obvious of casting the hell out of all my __u64s
when doing division and throwing away precision.)?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


