Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265635AbUAMUz3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 15:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265639AbUAMUz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 15:55:28 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:17650 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265635AbUAMUzU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 15:55:20 -0500
Message-ID: <40045B28.7000602@mvista.com>
Date: Tue, 13 Jan 2004 12:55:04 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: "Amit S. Kale" <amitkale@emsyssoft.com>, Andrew Morton <akpm@osdl.org>,
       jim.houston@comcast.net, discuss@x86-64.org, ak@suse.de,
       shivaram.upadhyayula@wipro.com, lkml <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [discuss] Re: kgdb for x86_64 2.6 kernels
References: <000e01c3d476$2ebe03a0$4008720a@shivram.wipro.com> <200401091031.41493.amitkale@emsyssoft.com> <3FFF2851.4060501@mvista.com> <200401101611.53510.amitkale@emsyssoft.com> <400237F0.9020407@mvista.com> <20040112094702.GB10869@elf.ucw.cz>
In-Reply-To: <20040112094702.GB10869@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>I'll attempt reading your patch and merging as much stuff as possible.
>>>Thanks.
>>
>>May I suggest reading the comments preceeding the patch itself in Andrew's 
>>breakout code.  These were written by Ingo and, I think, reflect some of 
>>the things he found useful.
>>
>>Also, the information found in .../Documentation/i386/kgdb/* of the
>>patch.
> 
> 
> Some docs would be nice, but we probably want to have it in
> Documentation/kgdb/, as it is no longer i386-specific.

and then sub arch under that for arch differences.  I like it.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

