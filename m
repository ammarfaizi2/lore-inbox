Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289342AbSBJIAp>; Sun, 10 Feb 2002 03:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289352AbSBJIAf>; Sun, 10 Feb 2002 03:00:35 -0500
Received: from h205n2fls34o809.telia.com ([217.208.95.205]:19406 "EHLO
	pizza.sajd.net") by vger.kernel.org with ESMTP id <S289342AbSBJIAZ>;
	Sun, 10 Feb 2002 03:00:25 -0500
Message-ID: <3C662896.4030303@telia.com>
Date: Sun, 10 Feb 2002 09:00:22 +0100
From: Pawel Worach <pawel.worach@telia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020208
X-Accept-Language: en, en-us, en-gb
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18-pre9
In-Reply-To: <3C662264.9090207@telia.com.suse.lists.linux.kernel> <p738za122to.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>.... abit bp6 with two intel celeron cpu's....


>>VM: killing process sendmail
>>swap_free: Unused swap offset entry 00004000
>>
>                                       ^^^^^^^^^
> Very much looks like a single bit memory corruption. And an unsupported 
> SMP configuration with a known-to-be-problematic board too. 
> I would suspect hardware.
> 

This system has been running linux for about 2 years without any problem 
at all, the hardware configuration has not changed one bit so i have a 
hard time beliving this is hardware. booted back into -pre7 and 
everything worked fine.

../Pawel

