Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965600AbWKDSns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965600AbWKDSns (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 13:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965603AbWKDSns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 13:43:48 -0500
Received: from rtr.ca ([64.26.128.89]:5905 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S965600AbWKDSnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 13:43:47 -0500
Message-ID: <454CDF62.2070602@rtr.ca>
Date: Sat, 04 Nov 2006 13:43:46 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com
Subject: Re: 2.6.19-rc3-git7: Oops on shutdown: do_remount_sb (reiserfs)
References: <45469414.4090108@rtr.ca> <20061104065708.GQ13381@stusta.de>
In-Reply-To: <20061104065708.GQ13381@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Mon, Oct 30, 2006 at 07:08:52PM -0500, Mark Lord wrote:
>> The system is a Core2duo with SATA drives, with a SLES10 install,
>> and a linux-2.6.19-rc3-git7 kernel.  All I did was a fresh boot to
>> the gdm prompt, and then selected "reboot" from the menu.
>>
>> Just as it was closing up shop, an Oops appeared on the screen.
>> I took a photo of it, and transcribed this portion (below).
>> The photograph is available on request.
> 
> Is this reproducible and still present in the latest -git?

Just a one-time event, thus far.  That doesn't mean the bug has gone away
(though it may have), it just means it doesn't happen too often.

I'll email you (Adrian) the photo privately, rather than spam the list with it.

Cheers


