Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbUDMRDq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 13:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263613AbUDMRDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 13:03:46 -0400
Received: from mail.tmr.com ([216.238.38.203]:529 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S263598AbUDMRDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 13:03:44 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Does OSS sound work in 2.6 or not?
Date: Tue, 13 Apr 2004 13:04:21 -0400
Organization: TMR Associates, Inc
Message-ID: <c5h6d2$fuu$1@gatekeeper.tmr.com>
References: <4075BDE0.6050302@tmr.com> <4075D155.2030603@tomt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1081875682 16350 192.168.12.100 (13 Apr 2004 17:01:22 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <4075D155.2030603@tomt.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Tomt wrote:

> OSS works just fine here in 2.6, on all the machines I have. I don't use 
> ALSA's OSS emulation layer, just the "native" OSS thats in the kernel. 
> It's used just like in 2.4, same module names and all. No black magic 
> involved.
> 
Let me provide a bit more detail. I have machines with "Vortex 
boomerang" sound cards. I have a 2.4 driver for same, for OSS, under 
NDA. In 2.6 those cards appear to be supported in ALSA, but using the 
OSS emulation everything seems to work except there isn't any sound.

I've had several people tell me that they are using OSS/2.6 without the 
ALSA utilities. I just want to know if that's possible or not, the 
people with the machines don't want ALSA for reasons I would call 
pigheaded stupidity if they weren't paying me to say "personal 
preference" ;-)

In any case, that's the question, can I get there from here? I can't use 
just OSS, the Vortex drivers are in ALSA.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
