Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752110AbWAEL77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbWAEL77 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 06:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752168AbWAEL76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 06:59:58 -0500
Received: from post.pl ([212.85.96.51]:5876 "HELO v00051.home.net.pl")
	by vger.kernel.org with SMTP id S1752110AbWAEL76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 06:59:58 -0500
Message-ID: <43BD09F4.2090603@post.pl>
Date: Thu, 05 Jan 2006 12:58:44 +0100
From: "Leonard Milcin Jr." <leonard.milcin@post.pl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Roberto Nibali <ratz@drugphish.ch>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: keyboard driver of 2.6 kernel
References: <Pine.LNX.4.60.0601041359380.7341@lantana.cs.iitm.ernet.in> <1136363622.2839.6.camel@laptopd505.fenrus.org> <43BB906F.3010900@post.pl> <Pine.LNX.4.61.0601041017560.29257@yvahk01.tjqt.qr> <43BCF005.1050501@drugphish.ch>
In-Reply-To: <43BCF005.1050501@drugphish.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Nibali wrote:
>>> Let's pretend it's some sort of auditing ;-)
>>
>> Actually, I use my keylogger (advertised above) more for "situation 
>> reconstruction" rather than spying. When you happen to have a multi-root
>> environment and people "forget what they did", stuff like ttyrpld can 
>> really be a gift compared to .bash_history (if it exists, after all).
> 
> If one needs it a bit less intrusive, she can also patch bash. A 
> possible solution can be found here:
> 
> http://www.drugphish.ch/patches/ratz/bash/bash-3.0-fix_1439-3.diff
> 
> But http://ttyrpld.sourceforge.net/ looks indeed interesting, however no 
> 2.4.x support from what I can see.
> 
> Regards,
> Roberto Nibali, ratz

This can be very easily circumvented if you can execute another shell 
(for example your own version of bash without patch).

L.
