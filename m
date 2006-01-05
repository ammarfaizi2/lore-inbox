Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWAEAIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWAEAIu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 19:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWAEAIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 19:08:50 -0500
Received: from terminus.zytor.com ([192.83.249.54]:55702 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750793AbWAEAIu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 19:08:50 -0500
Message-ID: <43BC636D.3070109@zytor.com>
Date: Wed, 04 Jan 2006 16:08:13 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Greg KH <greg@kroah.com>, Nick Warne <nick@linicks.net>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       webmaster@kernel.org
Subject: Re: 2.6.14.5 to 2.6.15 patch
References: <200601041710.37648.nick@linicks.net> <200601042010.36208.s0348365@sms.ed.ac.uk> <20060104220157.GB12778@kroah.com> <200601042249.12116.s0348365@sms.ed.ac.uk>
In-Reply-To: <200601042249.12116.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> 
> Re-read the thread. The confusion here is about "going back" to 2.6.14 before 
> patching 2.6.15. This has nothing to do with "rc kernels". We have this 
> documented explicitly in the kernel but not on the kernel.org FAQ.
> 

If you can send me some suggested verbiage I'll put it in the FAQ.  We 
can also make a page that's directly linked from the "stable release", 
kind of like we have info links for -mm patches etc.

	-hpa
