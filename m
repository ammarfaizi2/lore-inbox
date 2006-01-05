Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWAELvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWAELvg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 06:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752169AbWAELvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 06:51:35 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:53385 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1752168AbWAELvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 06:51:35 -0500
Date: Thu, 5 Jan 2006 12:51:31 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Roberto Nibali <ratz@drugphish.ch>
cc: "Leonard Milcin Jr." <leonard.milcin@post.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: keyboard driver of 2.6 kernel
In-Reply-To: <43BCF005.1050501@drugphish.ch>
Message-ID: <Pine.LNX.4.61.0601051249030.21555@yvahk01.tjqt.qr>
References: <Pine.LNX.4.60.0601041359380.7341@lantana.cs.iitm.ernet.in>
 <1136363622.2839.6.camel@laptopd505.fenrus.org> <43BB906F.3010900@post.pl>
 <Pine.LNX.4.61.0601041017560.29257@yvahk01.tjqt.qr> <43BCF005.1050501@drugphish.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Let's pretend it's some sort of auditing ;-)
>> 
>> Actually, I use my keylogger (advertised above) more for "situation
>> reconstruction" rather than spying. When you happen to have a multi-root
>> environment and people "forget what they did", stuff like ttyrpld can
>> really be a gift compared to .bash_history (if it exists, after all).
>
> If one needs it a bit less intrusive, she can also patch bash. A possible
> solution can be found here:
>
> http://www.drugphish.ch/patches/ratz/bash/bash-3.0-fix_1439-3.diff
>
> But http://ttyrpld.sourceforge.net/ looks indeed interesting, however no 2.4.x
> support from what I can see.

Do you really need 2.4 support? Well, after all, I can add it back, it's 
not too much #defines and stuff.


Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
