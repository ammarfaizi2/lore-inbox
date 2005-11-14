Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVKNWY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVKNWY1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 17:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVKNWY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 17:24:27 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:9646 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932099AbVKNWY1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 17:24:27 -0500
Message-ID: <43790F00.2020401@tmr.com>
Date: Mon, 14 Nov 2005 17:26:08 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linuv 2.6.15-rc1
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <4378980C.7060901@ens-lyon.fr> <20051114143248.GA3859@gemtek.lt>
In-Reply-To: <20051114143248.GA3859@gemtek.lt>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zilvinas Valinskas wrote:
> Hello, 
> 
> the same problem is present with 2.6.14 + ipw2200 1.0.8/ieee80211 1.1.6
> too. I didn't report problem as I am using madwifi drivers (which
> taints the kernel) and thought it was related to madwifi CVS (latest)
> and the newest ipw2200 drivers.
> 
> All crashes are happening right after messages are print:
> 
You are running the correct firmware? I don't have my system handy, but 
the Intel page says 2.4 firmware with the driver.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
