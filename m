Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131353AbRBDBGo>; Sat, 3 Feb 2001 20:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131355AbRBDBGf>; Sat, 3 Feb 2001 20:06:35 -0500
Received: from femail3.rdc1.on.home.com ([24.2.9.90]:55538 "EHLO
	femail3.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S131353AbRBDBGa>; Sat, 3 Feb 2001 20:06:30 -0500
Message-ID: <3A7CAB00.1E6F9E9D@Home.net>
Date: Sat, 03 Feb 2001 20:06:08 -0500
From: Shawn Starr <Shawn.Starr@Home.net>
Organization: Visualnet
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Marko Kreen <marko@l-t.ee>
CC: linux-kernel@vger.kernel.org
Subject: Re: PS hanging in 2.4.1 - HAPPENING NOW!!!
In-Reply-To: <3A7C8AC4.D3CAAF57@Home.net> <20010204031135.B23913@l-t.ee>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wasn't on shutdown though ;-)

I was just about to receive a message when things started to lock up slowly.
Then everything else followed.

Marko Kreen wrote:

> On Sat, Feb 03, 2001 at 05:48:36PM -0500, Shawn Starr wrote:
> > [root@coredump spstarr]# killall -9 gnomeicu
> >
> > ... waiting...
>
> Could you try it on 2.4.2ac2, I guess its this item:
>
> o       Fix datagram hang on shutdown                   (Alexey
> Kuznetsov)
>
> --
> marko
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
