Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbUBOO7y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 09:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUBOO7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 09:59:54 -0500
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:61312 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264929AbUBOO7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 09:59:53 -0500
Message-ID: <402F8967.1050405@uchicago.edu>
Date: Sun, 15 Feb 2004 08:59:51 -0600
From: Ryan Reich <ryanr@uchicago.edu>
User-Agent: Mozilla Thunderbird 0.5+ (X11/20040211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: is nForce2 good choice under Linux?
References: <1oRXf-7zC-13@gated-at.bofh.it> <1oSgx-7QJ-11@gated-at.bofh.it> <1oSJA-8nw-17@gated-at.bofh.it> <1oTPp-YO-25@gated-at.bofh.it> <1pt6s-686-9@gated-at.bofh.it>
In-Reply-To: <1pt6s-686-9@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sander wrote:
> Jesse Allen wrote (ao):
> 
>> On Fri, Feb 13, 2004 at 11:01:45PM +0200, aviv bergman wrote:
>>> i had very frequent lockups after upgrading to 2.6.0, flashed to the
>>>  latest bios, and the system is rock stable since (2.6.1 w/apic)
>> 
>> Wow, another fixed shuttle board? Looks like shuttle knows what the
>> bug is then.
> 
> 
> I've never read the Shuttle boards where unstable. I thought people had
> problems with the normal size boards from Asus and others.

I have a Shuttle AN35N-Ultra with an Athlon 2600+ on it which had the
infamous lockups under 2.4 until I figured out that it was the APIC and
turned that off.  I just flashed the BIOS with the latest on Shuttle's site
and they seem to have gone, at least for now.  Someone claims that he got
one after five days uptime, but I'm a wimp and turn my computer off every
night so I'll never see that.

-- 
Ryan Reich
ryanr@uchicago.edu
