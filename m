Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311614AbSDDU7x>; Thu, 4 Apr 2002 15:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311615AbSDDU7n>; Thu, 4 Apr 2002 15:59:43 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:59369 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S311614AbSDDU7f>; Thu, 4 Apr 2002 15:59:35 -0500
Date: Thu, 4 Apr 2002 22:57:56 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <Pine.LNX.3.95.1020404095833.16825A-100000@chaos.analogic.com>
Message-ID: <Pine.NEB.4.44.0204042244130.7845-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002, Richard B. Johnson wrote:

>...
> I am amazed with the number of "lawyers" we have here. Maybe it's
> just some semantics or property of translation, but it is not
> illegal to violate a license.
>
> The term "illegal" historically refers to laws. Laws are rules
> enacted by governments.
>
> A license is permission, granted by a property owner, usually
> but not always, setting forth the conditions of use.
>...

IANAL but my one-and-a-half-years-old copy of German copyright law says
(very shortened):

<--  snip  -->

Zu den geschuetzten Werken ... gehoeren insbesondere:
- ... Computerprogramme
...
Wer in anderen als den gesetzlich zugelassenen Faellen ohne Einwilligung
eines Berechtigten ein Werk oder eine Bearbeitung oder Umgestaltung eines
Werkes vervielfaeltigt, verbreitet oder oeffentlich wiedergibt, wird mit
Freiheitsstrafe bis zu drei Jahren oder mit Geldstrafe bestraft.
...
Handelt der Taeter ... gewerbsmaessig, so ist die Strafe Freiheitsstrafe
bis zu fuenf Jahre oder Geldstrafe.
...

<--  snip  -->

A _very rough_ summary (I don't think I can really translate this legal
text correctly - there are perhaps people on this list who can make a
real translation) is:

If you copy a computer program in a case where it's not permitted by law
without the permission of the copyright holder the penalty is a fine or up
to three years prison. If you do this commercially the penalty is a fine
or up to five years prison.

> Cheers,
> Dick Johnson

cu
Adrian


