Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWGFJoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWGFJoz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 05:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWGFJoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 05:44:55 -0400
Received: from smtp811.mail.ukl.yahoo.com ([217.12.12.201]:41888 "HELO
	smtp811.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030190AbWGFJoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 05:44:55 -0400
Message-ID: <44ACDB94.4040201@btinternet.com>
Date: Thu, 06 Jul 2006 10:44:52 +0100
From: Matt Keenan <matt.keenan@btinternet.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060619)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc1
References: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607052115210.12404@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

[snip snip]
> The changes are too big for the mailing list, even just the shortlog. As 
> usual, lots of stuff happened. Most architectures got updated, ACPI 
> updates, networking, SCSI and sound, IDE, infiniband, input, DVB etc etc 
> etc.
>
>   
[snip snip]
> Git users should generally just select the part they are interested in, 
> and do something like
>
> 	git log v2.6.17.. -- drivers/usb/ | git shortlog | less -S
>
> to get a better and more focused view of what has changed.
>   
[snip snip]

Is it possible to get a URL to a shortlog on a web git somewhere? Has 
this information been posted before and I have missed it?

Matt

