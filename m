Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVCCBkl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVCCBkl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 20:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVCCBg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 20:36:58 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:33936 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261254AbVCCBgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 20:36:00 -0500
Message-ID: <422669F4.9020706@candelatech.com>
Date: Wed, 02 Mar 2005 17:35:48 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Massimo Cetra <mcetra@navynet.it>
CC: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel release numbering
References: <20050303010615.3C7F184008@server1.navynet.it>
In-Reply-To: <20050303010615.3C7F184008@server1.navynet.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Massimo Cetra wrote:

> So, why moving from 2.6.14 to 2.6.15 when, in 2/4 weeks, i'll have a more
> stable 2.6.16 ? 
> Will users help testing an odd release to have a good even release ? Or will
> they consider an even release as important as a -RC release ?

I think it would be useful for folks to test the 2.6.ODD release because
the understanding is that 2.6.ODD+1 will be out soon, and we are pretty
sure there won't be any large changes in that transition.  Any out-side-the-tree
patches will probably apply to both of these w/out manual hacking,
which also makes testing easier.

I am less likely to test an ODD.pre-Z release because there is likely to be
a large pile coming after that, which means that even if pre-Z worked
fine, I still have to be very paranoid about the final release.

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

