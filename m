Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129155AbRBSOkF>; Mon, 19 Feb 2001 09:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129491AbRBSOjz>; Mon, 19 Feb 2001 09:39:55 -0500
Received: from f223.law7.hotmail.com ([216.33.237.223]:39174 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129364AbRBSOjt>;
	Mon, 19 Feb 2001 09:39:49 -0500
X-Originating-IP: [195.171.24.4]
From: "lafanga lafanga" <lafanga1@hotmail.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Proliant hangs with 2.4 but works with 2.2.
Date: Mon, 19 Feb 2001 14:39:42 -0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F223BDXmDQOa8NlgXjs0000598e@hotmail.com>
X-OriginalArrivalTime: 19 Feb 2001 14:39:42.0522 (UTC) FILETIME=[CBB131A0:01C09A81]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

I'll be happy to test out 2.2.19pre. I'm having a little difficulty locating 
it though on kernel.org. Can you or somebody send me a URL for this.

Thanks.


>From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>To: lafanga1@hotmail.com (lafanga lafanga)
>CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
>Subject: Re: Proliant hangs with 2.4 but works with 2.2.
>Date: Mon, 19 Feb 2001 11:37:49 +0000 (GMT)
>
> > You were spot on. Indeed touching the device file causes it to hang. 
>Should
> > I recompile the kernel in a particular way to avoid this?
>
>I'd be interested to know if 2.2.19pre works or not. I'd like to fix the 
>hang
>most definitely.
>
>As a short term cure
>
>rm /dev/psaux
>
>you can use mknod to put it back if you ever need to. But that will disable
>PS/2 mouse support on that box somewhat
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

