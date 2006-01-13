Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423006AbWAMWKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423006AbWAMWKY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423008AbWAMWKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:10:23 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:42421 "EHLO
	localhost") by vger.kernel.org with ESMTP id S1423007AbWAMWKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:10:21 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades
To: Free Ekanayaka <free@64studio.com>
Subject: Re: [Free Ekanayaka] Re: realtime-preempt and suspend2
Date: Sat, 14 Jan 2006 08:10:44 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <87ek3c8279.fsf@miu-ft.org>
In-Reply-To: <87ek3c8279.fsf@miu-ft.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601140810.44818.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Saturday 14 January 2006 03:31, Free Ekanayaka wrote:
> Hi,
>
> I'm resending this email as for some reason it is not in the kernel ml
> archives, so I suspect it wasn't delivered properly..
>
> |--==> Nigel Cunningham writes:
>
>   NC> Hi.
>
>   NC> On Wednesday 11 January 2006 20:39, Free Ekanayaka wrote:
>   >>Hi,
>   >>
>   >>I'd like  to use both  the realtime-preempt  and the suspend2 patches,
>   >>but the seem to conflict in (I tried to apply them on 2.6.15).
>   >>
>   >>Did anybody experiment such combination?
>
>   NC> Give me more detail and I'll see if I can help.
>
> Thanks, the patch sequence is:
>
> 1) pristine kernel 2.6.15
> 2) suspend2 patch 2.2-rc16 (I used the apply script incl in the source
> tarball) [0] 3) realtime-preempt 2.6.15-rt2
>
> Of  course the  suspend2  patch applies happily,   but when I try with
> realtime-preempt I get some rejects, here is the log:
>
> http://people.miu-ft.org/~free/2.6.15+suspend2+rt.log

Thanks. I did see the message, but simply haven't had the time to get around 
to it yet. Thanks for the reminder.

Regards,

Nigel
