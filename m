Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVCVNQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVCVNQX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 08:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVCVNQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 08:16:23 -0500
Received: from smtp1.dejazzd.com ([66.109.229.7]:23705 "EHLO smtp1.dejazzd.com")
	by vger.kernel.org with ESMTP id S261200AbVCVNQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 08:16:21 -0500
Message-ID: <423FD410.2050607@ser1.net>
Date: Tue, 22 Mar 2005 03:15:12 -0500
From: Sean Russell <ser@ser1.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050226)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org, nipsy@bitgnome.net
Subject: Re: 2.6.1[01] freeze on x86_64
References: <423F5152.2010303@ser1.net> <m13buo3vew.fsf@muc.de> <423FC2ED.1090704@ser1.net> <Pine.LNX.4.61.0503221317220.10134@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0503221317220.10134@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>>Er... by serial console, I assume you mean via a serial cable and some other
>>device.  If so, then no, I don't have that capability.  I didn't know about
>>netconsole before you mentioned it; I'll do some research and set it up.  I do
>>    
>>
>Serial console -- only requires a serial cable, available in the next computer 
>store -- also works with non-Linux, non-x86 and (mostly) systems-w/o-compiler.
>  
>
Well, that and the knowledge of how to monitor it on the other end, 
which I lack :-).  And does one need a null-modem cable?  I haven't used 
serial cables since USB was introduced.  Is serial monitoring preferred 
over netconsole?

In any case, I've figured out how to get netconsole working, and have 
started monitoring it from my wife's laptop.  I just need to reboot and 
make sure it is working (that I got the UDP addresses right), and then 
wait for a crash.  I won't get to this until this evening, probably.

Mark, I'm going to start CC'ing you, and I'll forward you the previous 
emails.

Thanks, everybody, for responding.

--- SER
