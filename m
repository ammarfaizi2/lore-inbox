Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWCPWq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWCPWq3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 17:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWCPWq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 17:46:29 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:6741 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S964888AbWCPWq2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 17:46:28 -0500
Message-ID: <4419E2D3.3060306@tmr.com>
Date: Thu, 16 Mar 2006 17:12:35 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16-rc6
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

clearly there's some small risk factor and youLinus Torvalds wrote:
> Ok, we're getting closer, although the 2.6.16 release certainly seems to 
> drag out more than it should have.
> 
> Some of the worrisome bootup problems seem to have been resolved to a 
> stupid build-time race, where we just generated an empty version string. 
> Oops. 
> 
> The diffstat shows that the largest changes here are the ia64 defconfig 
> updates, much of the rest really is pretty small, but all over the map. 
> Some ocfs2 and 9pfs fixes and updates, and various driver and networking 
> fixes.
> 
> The ShortLog (appended) gives a pretty good picture of it,
> 
> 		Linus

I don't see the bttv fix from Duncan Sands. I realize that similar 
mistakes are in other drivers, but bttv is popular and would benefit 
from getting a fix which works, and several posters have confirmed that 
it really does.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

