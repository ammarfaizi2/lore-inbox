Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWGSNsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWGSNsP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 09:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWGSNsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 09:48:15 -0400
Received: from mail-ale01.alestra.net.mx ([207.248.224.149]:59126 "EHLO
	mail-ale01.alestra.net.mx") by vger.kernel.org with ESMTP
	id S964816AbWGSNsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 09:48:15 -0400
Message-ID: <44BE37E8.2040706@att.net.mx>
Date: Wed, 19 Jul 2006 08:47:20 -0500
From: Hugo Vanwoerkom <rociobarroso@att.net.mx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: ocilent1 <ocilent1@gmail.com>, Lee Revell <rlrevell@joe-job.com>,
       Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       linux list <linux-kernel@vger.kernel.org>, dsd@gentoo.org
Subject: Re: sound skips on 2.6.16.17
References: <200606181204.29626.ocilent1@gmail.com> <1152289985.4736.86.camel@mindpipe> <20060707170045.GA23243@tuatara.stupidest.org> <200607191403.26174.ocilent1@gmail.com> <20060719063344.GA1677@tuatara.stupidest.org>
In-Reply-To: <20060719063344.GA1677@tuatara.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Wed, Jul 19, 2006 at 02:03:25PM +0800, ocilent1 wrote:
>
>   
>> Hows progress on this bug? Don't suppose we have got an official fix
>> for this somewhere on the horizon?
>>     
>
> Daniel Drake posted this recently, I've not had a chance to look over
> it in detail but it's probably the best tested suggestion thus far.
>
> Does it work for you?
>
>
>   
<snip>

I tried that on 2.6.17-ck1 with good results:

...
patching file drivers/pci/quirks.c
Hunk #1 succeeded at 638 (offset -10 lines).
Hunk #2 succeeded at 678 (offset -10 lines).
...

Regards,

Hugo
