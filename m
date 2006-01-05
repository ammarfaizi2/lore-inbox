Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751686AbWAEQn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbWAEQn1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 11:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbWAEQn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 11:43:27 -0500
Received: from terminus.zytor.com ([192.83.249.54]:15001 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751686AbWAEQn0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 11:43:26 -0500
Message-ID: <43BD4C8F.3040703@zytor.com>
Date: Thu, 05 Jan 2006 08:42:55 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: Jesper Juhl <jesper.juhl@gmail.com>, Greg KH <greg@kroah.com>,
       Nick Warne <nick@linicks.net>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, webmaster@kernel.org
Subject: Re: 2.6.14.5 to 2.6.15 patch
References: <200601041710.37648.nick@linicks.net> <200601051525.05613.s0348365@sms.ed.ac.uk> <9a8748490601050737y24f04505hb605fbe96fe4f92c@mail.gmail.com> <200601051555.25915.s0348365@sms.ed.ac.uk>
In-Reply-To: <200601051555.25915.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
>>
>>Nice writeup, but why not simply put a copy of
>>Documentation/applying-patches.txt online and link to that?
>>It contains more or less the same stuff you just wrote.
> 
> It's certainly one possibility, but this file is at least 4x more verbose than 
> my summary. I aimed to write something instructional, rather than provide a 
> complete explanation of the "patch problem".
> 
> If this issue is large enough to get its own page on kernel.org, then a more 
> complete description may indeed be justified. Comments?
> 

It'd be easy to make its own page, and then link it from the FAQ.  Heck, 
the easiest might be to link it to the gitweb checkout of 
Documentation/applying-patches.txt, but having it be nicely HTML 
formatted would probably be better.

	-hpa
