Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262436AbRFFX64>; Wed, 6 Jun 2001 19:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbRFFX6r>; Wed, 6 Jun 2001 19:58:47 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:58760 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262436AbRFFX6i>; Wed, 6 Jun 2001 19:58:38 -0400
Date: Wed, 6 Jun 2001 17:51:24 -0600
Message-Id: <200106062351.f56NpOs20522@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "David S. Miller" <davem@redhat.com>
Cc: "Matt D. Robinson" <yakker@alacritech.com>,
        "La Monte H.P. Yarroll" <piggy@em.cig.mot.com>,
        linux-kernel@vger.kernel.org, sctp-developers-list@cig.mot.com
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
In-Reply-To: <15134.48456.5360.764458@pizda.ninka.net>
In-Reply-To: <200106051659.LAA20094@em.cig.mot.com>
	<3B1E5CC1.553B4EF1@alacritech.com>
	<15134.42714.3365.32233@theor.em.cig.mot.com>
	<15134.43914.98253.998655@pizda.ninka.net>
	<3B1EBB13.34721ED9@alacritech.com>
	<15134.48456.5360.764458@pizda.ninka.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
> 
> Matt D. Robinson writes:
>  > > This allows people to make proprietary implementations of TCP under
>  > > Linux.  And we don't want this just as we don't want to add a way to
>  > > allow someone to do a proprietary Linux VM.
>  > 
>  > And if as Joe User I don't want Linux TCP, but Joe's TCP, they can't
>  > do that (in a supportable way)?  Are you saying Linux is, "do it my
>  > way, or it's the highway"?

Pardon my cynicism, but this reads more like "I'm an ACME Inc. and I
want to sell a proprietary TCP stack for Linux, please change Linux to
make this possible/easy". I doubt there are many Joe Users out there
who want to replace their TCP stack. I bet they would be much happier
to see patches go in which improve the performance of the generic
kernel.

But I'm sure there are plenty of ACME Inc.'s out there who would love
to sell a replacement TCP stack. And suck users down a proprietary
solution path. But I don't see why the Linux community should help the
ACME's of this world. And Linux is doing very nicely in the corporate
world, so we needn't to lose any sleep over what our current policies
do for our acceptance levels.

If it bothers you that Linux caters more the the users and less to the
vendors, then use another OS. We don't mind. The door is over there.
Please don't slam it on your way out.

> If Joe's TCP is opensource, they are more than welcome to publish
> such changes.

Yep. And then we can all benefit.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
