Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261699AbTCZNw1>; Wed, 26 Mar 2003 08:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261700AbTCZNw1>; Wed, 26 Mar 2003 08:52:27 -0500
Received: from relay04.valueweb.net ([216.219.253.238]:44008 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id <S261699AbTCZNw0>; Wed, 26 Mar 2003 08:52:26 -0500
Message-ID: <3E81B317.3080504@coyotegulch.com>
Date: Wed, 26 Mar 2003 09:03:03 -0500
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030319 Debian/1.3-3
X-Accept-Language: en
MIME-Version: 1.0
To: James Simmons <jsimmons@infradead.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Framebuffer updates.
References: <Pine.LNX.4.33.0303251032320.4272-100000@maxwell.earthlink.net>
In-Reply-To: <Pine.LNX.4.33.0303251032320.4272-100000@maxwell.earthlink.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> As usually I have a patch avalaible at 
> The patch has updates for the ATI Rage 128, Control, and Platnium 
> framebuffer driver. The Radeon patch adds PLL times for the R* series of
> cards. Memory is now safe to allocate for the software cursor and inside 
> fbcon. There still are issues with syncing which cause the cursor on some 
> systems to become corrupt sometimes. 

 From your description, this doesn't sound like these patches solve the 
problem with radeonfb not detecting a DFP connected to the DVI. I posted 
a message about this bug a week ago, and am more than willing to look 
into fixing it myself if it isn't on your schedule.

-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)


