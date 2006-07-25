Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWGYUSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWGYUSf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbWGYUSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:18:35 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:22680
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S964852AbWGYUSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:18:34 -0400
Message-ID: <44C67C04.20108@microgate.com>
Date: Tue, 25 Jul 2006 15:16:04 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: Greg KH <greg@kroah.com>, linux-stable <stable@kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [stable] Success: tty_io flush_to_ldisc() error message  triggered
References: <200607251522_MC3-1-C616-70EA@compuserve.com>
In-Reply-To: <200607251522_MC3-1-C616-70EA@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> In-Reply-To: <20060725184158.GH9021@kroah.com>
> 
> On Tue, 25 Jul 2006 11:41:58 -0700, Greg KH wrote:
> 
>>>>Is this simpler change (what I'm running but without the warning
>>>>messages) the preferred fix for -stable?
>>>
>>>It fixes the problem.
>>
>>So do you feel this patch should be added to the -stable kernel tree?
> 
> 
> I think it's the right fix.
> 
>         1.  It fixes a real bug and that's been verified by testing.
>         2.  It's the simplest change that does so. (The fix in 2.6.18-rc
>             touches a lot of code.)

OK, I have no objections (it saves me time).
I'll let you guys decide.

-- 
Paul Fulghum
Microgate Systems, Ltd.
