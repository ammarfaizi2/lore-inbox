Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290917AbSASHIv>; Sat, 19 Jan 2002 02:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290918AbSASHIk>; Sat, 19 Jan 2002 02:08:40 -0500
Received: from f58.law14.hotmail.com ([64.4.21.58]:1811 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S290917AbSASHIa>;
	Sat, 19 Jan 2002 02:08:30 -0500
X-Originating-IP: [203.145.133.194]
From: "Raman S" <raman_s_@hotmail.com>
To: mjustice@austin.rr.com, linux-kernel@vger.kernel.org
Subject: Re: [Question] Viewing and changing memory contents in Linux
Date: Fri, 18 Jan 2002 23:08:24 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F58c0D543TuylJc0xvl0000505e@hotmail.com>
X-OriginalArrivalTime: 19 Jan 2002 07:08:24.0575 (UTC) FILETIME=[15F2E0F0:01C1A0B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I guess I should be using kdb... Thanks.
Raman S

>From: Marvin Justice <mjustice@austin.rr.com>
>Reply-To: mjustice@austin.rr.com
>To: "Raman S" <raman_s_@hotmail.com>, linux-kernel@vger.kernel.org
>Subject: Re: [Question] Viewing and changing memory contents in Linux
>Date: Sat, 19 Jan 2002 00:46:30 -0600
>
>gdb lets you do it - but only for virtual addresses in the context of a
>specific process. If you're talking about memory referenced by physical
>address then I guess you'd have to be in kernel mode.
>
>-Marvin
>
>
>On Friday 18 January 2002 10:43 pm, Raman S wrote:
> > Hi,
> >   Is there an open source utility that allows viewing and modifying
> > memory contents dynamically while the system is running.....
> >    Thanks.
> > Raman S
> >
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp.

