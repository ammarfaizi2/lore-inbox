Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbTDUWiJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 18:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTDUWiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 18:38:09 -0400
Received: from dhcp93-dsl-usw3.w-link.net ([206.129.84.93]:48565 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id S262627AbTDUWiI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 18:38:08 -0400
Message-ID: <3EA47596.9060901@candelatech.com>
Date: Mon, 21 Apr 2003 15:49:58 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc1
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Here goes the first candidate for 2.4.21.
> 
> Please test it extensively.
> 
> <green@linuxhacker.ru>:
>   o [VLAN]: Fix memory leak in procfs handling

I looked at the diff on kernel.org to peruse this change, and did not see any
changes to any vlan files??

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


