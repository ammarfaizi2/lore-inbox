Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284246AbRLAUnm>; Sat, 1 Dec 2001 15:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284248AbRLAUnb>; Sat, 1 Dec 2001 15:43:31 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:23454 "HELO
	postfix2-1.free.fr") by vger.kernel.org with SMTP
	id <S284251AbRLAUn1> convert rfc822-to-8bit; Sat, 1 Dec 2001 15:43:27 -0500
Date: Sat, 1 Dec 2001 18:50:11 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: 2 small patches against 2.4.17-pre2 (sym2 + email change)
In-Reply-To: <3C093029.EEF79D5A@mandrakesoft.com>
Message-ID: <20011201184332.E2444-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 Dec 2001, Jeff Garzik wrote:

> Gérard Roudier wrote:
> >         * version sym-2.1.17a
> >         - Use u_long instead of U32 for the IO base cookie. This is more
> >           consistent with what archs are expecting.
>
> Well...  if you want to speak of style, no arch uses 'u_long'... rather
> they use 'unsigned long' :)

I don't at any mailing list that has something to do with programming. :)

   Gérard.

PS: This email should not have gone to the list. I missed to remove the
    LKML from the cc.

