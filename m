Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271321AbRICIAg>; Mon, 3 Sep 2001 04:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271371AbRICIA0>; Mon, 3 Sep 2001 04:00:26 -0400
Received: from ns.roland.net ([65.112.177.35]:58628 "EHLO earth.roland.net")
	by vger.kernel.org with ESMTP id <S271321AbRICIAT>;
	Mon, 3 Sep 2001 04:00:19 -0400
Message-ID: <001e01c1344e$e4bab7e0$bb1cfa18@JimWS>
From: "Jim Roland" <jroland@roland.net>
To: "David Hollister" <david@digitalaudioresources.org>
Cc: "Jan Niehusmann" <jan@gondor.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20010831044247.B811@gondor.com> <3B8EFF67.9010409@digitalaudioresources.org> <001101c132cd$cbbf7050$bb1cfa18@JimWS> <3B90F310.1030808@digitalaudioresources.org>
Subject: Re: Athlon doesn't like Athlon optimisation?
Date: Mon, 3 Sep 2001 03:03:18 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm...missed that patch, but I'm not on 2.4.9 yet.  Can someone email that
to me directly or repost to the list?

----- Original Message -----
From: "David Hollister" <david@digitalaudioresources.org>
To: "Jim Roland" <jroland@roland.net>
Cc: "Jan Niehusmann" <jan@gondor.com>; <linux-kernel@vger.kernel.org>
Sent: Saturday, September 01, 2001 9:39 AM
Subject: Re: Athlon doesn't like Athlon optimisation?


> Jim Roland wrote:
> > Which kernel are you gentlemen using?  I have a Athlon 1.2GHz (not
> > overclocked), 512MB PC133, and also an EPoX 8KTA3+, and have had no
problems
> > whatsoever (using kernel 2.4.2-2).
>
> I'm on 2.4.9.  No overclocking.  I applied the patch that somebody (sorry,
> forgot who) posted yesterday for arch/i386/lib/mmx.c and rebuilt the
kernel with
> Athlon optimization.  It now works.
> --
> David Hollister
> Driversoft Engineering:  http://devicedrivers.com
> Digital Audio Resources: http://digitalaudioresources.org
>

