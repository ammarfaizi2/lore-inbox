Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154604AbPFCAGr>; Wed, 2 Jun 1999 20:06:47 -0400
Received: by vger.rutgers.edu id <S153938AbPFBXpF>; Wed, 2 Jun 1999 19:45:05 -0400
Received: from snipe.prod.itd.earthlink.net ([207.217.120.62]:62074 "EHLO snipe.prod.itd.earthlink.net") by vger.rutgers.edu with ESMTP id <S154638AbPFBVpj>; Wed, 2 Jun 1999 17:45:39 -0400
Message-ID: <3755C2AE.4FFFCA2F@earthlink.net>
Date: Wed, 02 Jun 1999 16:47:58 -0700
From: Vince Lo Faso <vincelofaso@earthlink.net>
X-Mailer: Mozilla 4.51 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: jordy@wserv.com, linux-kernel@vger.rutgers.edu
Subject: Re: XTP: A better TCP than TCP
References: <37544C46.C9A1AA12@wserv.com> <199906020426.VAA03202@pizda.davem.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Greetings,

I've been working on an XTP implementation for Linux for some time
(and will be the first to admit that I'm order due for releasing
it publically).

I recently  ported it to kernel 2.3.x and am in the process of (re)sending
a patch to David.

I'm doing this strictly on a volunteer basis, which means I can respond to
emails
during the evenings and have limitted time for its development--but unlimitted

interested in its growth and potential.  More info will follow.

Quick synopsis of XTP:

XTP is quite flexible and versatile, capable of offering UDP-like and TCP-like

services--and everything in between--in one protocol stack.  However, its
flexibility
is also its weak point.  There is little public
data-experience-testing-implementation
on making XTP work in an IP environment, hence this XTP-Linux project.
There are also several transport issues that need to be explored in an XTP/IP
environment.

If anyone is really interested in this and wants to help out, let me know
offline.

Thanks,

Vince.


"David S. Miller" wrote:

>    Date:        Tue, 01 Jun 1999 17:10:30 -0400
>    From: Jordan Mendelson <jordy@wserv.com>
>
>    Is there any projects out there to add XTP to the standard linux
>    kernel?
>
> There is someone who is working on XTP/Linux and keeps sending me
> patches, but they always need massive formatting cleanups before I can
> apply them and then he disappears again for a few months.
>
> This is not necessarily his fault, he may not have the time to finish
> up and submit patches cleanly, but until _someone_ does this work I
> cannot even put his work in progress code into the tree.
>
> Later,
> David S. Miller
> davem@redhat.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.rutgers.edu
> Please read the FAQ at http://www.tux.org/lkml/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
