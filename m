Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270858AbTHOUoe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 16:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270859AbTHOUoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 16:44:34 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:40591 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270858AbTHOUoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 16:44:32 -0400
Message-ID: <3F3D469B.2020507@yahoo.com>
Date: Fri, 15 Aug 2003 16:46:19 -0400
From: Brandon Stewart <rbrandonstewart@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bryan O'Sullivan" <bos@serpentine.com>
CC: Jan Rychter <jan@rychter.com>, linux-kernel@vger.kernel.org
Subject: Re: Centrino support
References: <m2wude3i2y.fsf@tnuctip.rychter.com> <1060972810.29086.8.camel@serpentine.internal.keyresearch.com>
In-Reply-To: <1060972810.29086.8.camel@serpentine.internal.keyresearch.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought that this line of argument was due to FCC regulations. That 
is, software settings would allow the hardware to violate frequency or 
strength-of-signal limitations set by government regulations. This is 
only from memory, so feel free to correct.

-Brandon

Bryan O'Sullivan wrote:

>On Fri, 2003-08-15 at 11:13, Jan Rychter wrote:
>  
>
>>Well, that was almost 5 months ago. So I figured I'd ask if there's any
>>progress -- so far the built-in wireless in my notebook still doesn't
>>work with Linux and the machine is monstrously power-hungry because
>>Linux doesn't scale the CPU frequency.
>>    
>>
>
>Intel shows no inclination to release Centrino wireless drivers for
>Linux.  There have been vague insinuations that this is due to excessive
>software controllability, but no public explanations have been given,
>beyond "we're not doing it at this moment".
>
>If you want built-in wireless in the nearish term, you'll have to get a
>supported MiniPCI card and replace your Centrino card.
>
>As far as CPU is concerned, if you're using recent 2.5 or 2.6 kernels,
>there's Pentium M support in cpufreq.  Jeremy Fitzhardinge has written a
>userspace daemon that varies the Pentium M CPU frequency in response to
>load.
>

