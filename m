Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264241AbRFFX0h>; Wed, 6 Jun 2001 19:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264245AbRFFX02>; Wed, 6 Jun 2001 19:26:28 -0400
Received: from smtp.alacritech.com ([209.10.208.82]:37125 "EHLO
	smtp.alacritech.com") by vger.kernel.org with ESMTP
	id <S264241AbRFFX0U>; Wed, 6 Jun 2001 19:26:20 -0400
Message-ID: <3B1EBB13.34721ED9@alacritech.com>
Date: Wed, 06 Jun 2001 16:21:55 -0700
From: "Matt D. Robinson" <yakker@alacritech.com>
Organization: Alacritech, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: "La Monte H.P. Yarroll" <piggy@em.cig.mot.com>,
        linux-kernel@vger.kernel.org, sctp-developers-list@cig.mot.com,
        yakker@alacritech.com
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
In-Reply-To: <200106051659.LAA20094@em.cig.mot.com>
		<3B1E5CC1.553B4EF1@alacritech.com>
		<15134.42714.3365.32233@theor.em.cig.mot.com> <15134.43914.98253.998655@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> La Monte H.P. Yarroll writes:
>  > Matt D. Robinson writes:
>  >  > Is there any way to add in the capability to _replace_ TCP with
>  >  > your own, so you can use your own layer?
> 
> ABSOLUTELY NOT!
> 
> And I will never in my lifetime allow such a facility to be added to
> the Linux kernel.

Who's to say you will always own the stack in the Linux kernel, or
have the right to make such a statement?

> This allows people to make proprietary implementations of TCP under
> Linux.  And we don't want this just as we don't want to add a way to
> allow someone to do a proprietary Linux VM.

And if as Joe User I don't want Linux TCP, but Joe's TCP, they can't
do that (in a supportable way)?  Are you saying Linux is, "do it my
way, or it's the highway"?

Seems rather Microsoft-ish of an attitude, if you ask me.

I think this is EXACTLY the reason why you run into companies like
Caldera and Microsoft saying that Linux stifles innovation.  You say,
"Oh, we allow you to do whatever you want", and when someone really
does want to do that in a way that works for open source and for
proprietary/high-security developers, you slam the door in their face.

Quite a shame.

Take it easy,

--Matt

> Later,
> David S. Miller
> davem@redhat.com
