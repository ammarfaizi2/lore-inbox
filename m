Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129154AbRBOOuv>; Thu, 15 Feb 2001 09:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129276AbRBOOum>; Thu, 15 Feb 2001 09:50:42 -0500
Received: from f58.law9.hotmail.com ([64.4.9.58]:16913 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129290AbRBOOuc>;
	Thu, 15 Feb 2001 09:50:32 -0500
X-Originating-IP: [212.58.173.129]
From: "Jonathan Brugge" <jonathan_brugge@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem: NIC doesn't work anymore, SIOCIFADDR-errors
Date: Thu, 15 Feb 2001 15:50:22 +0100
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F58rzPx7YhppLfuV5zy00015e11@hotmail.com>
X-OriginalArrivalTime: 15 Feb 2001 14:50:22.0447 (UTC) FILETIME=[9F76FFF0:01C0975E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, I do...
Thanks for the hints, I've installed the older version, then upgraded to the 
fixed version. Everything works now as before.

Jonathan Brugge


>From: David Raufeisen <david@fortyoz.org>
>Reply-To: David Raufeisen <david@fortyoz.org>
>To: Jonathan Brugge <jonathan_brugge@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re:  Problem: NIC doesn't work anymore, SIOCIFADDR-errors
>Date: Wed, 14 Feb 2001 06:36:20 -0800
>
>Are you using the net-tools from debian? There was a broken one causing 
>these
>errors the last few days, is fixed now.
>
>On Wednesday, 14 February 2001, at 15:17:09 (+0100),
>Jonathan Brugge wrote:
>
> > Here's the output from dmesg, after deleting some unimportant stuff like
> > sound and graphics-init. I don't see any errors that have something to 
>do
> > with my NIC, the detected type (Winbond 89C940) is the right one.
> >
> > Linux version 2.4.0-prerelease (root@odysseus) (gcc version 2.95.3 
>20010125
> > (prerelease)) #2 Tue Feb 13 20:27:53 CET 2001
>
>--
>David Raufeisen <david@fortyoz.org>
>Cell: (604) 818-3596
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

