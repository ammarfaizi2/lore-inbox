Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbSKTErl>; Tue, 19 Nov 2002 23:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265727AbSKTErl>; Tue, 19 Nov 2002 23:47:41 -0500
Received: from mta04bw.bigpond.com ([139.134.6.87]:46038 "EHLO
	mta04bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S265725AbSKTErk>; Tue, 19 Nov 2002 23:47:40 -0500
Message-ID: <002301c2905f$ec818800$0100000a@r1a4n3>
From: "archaios" <quack@bigpond.net.au>
To: "Ross Vandegrift" <ross@willow.seitz.com>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0211192036530.30881-100000@blessed.joshisanerd.com> <Pine.LNX.4.44L.0211200057370.4103-100000@imladris.surriel.com> <20021120042624.GA21122@willow.seitz.com>
Subject: Re: spinlocks, the GPL, and binary-only modules
Date: Wed, 20 Nov 2002 17:41:56 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When you GPL a piece of software, you sign over your rights to the FSF. Therefore, there is very little that can be done about this;
from a legal perspective, the FSF _itself_ determines what is and what isn't construed as a derived work.

- David McIlwraith
----- Original Message -----
From: Ross Vandegrift <ross@willow.seitz.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, November 20, 2002 3:26 PM
Subject: Re: spinlocks, the GPL, and binary-only modules


On Wed, Nov 20, 2002 at 12:59:26AM -0200, Rik van Riel wrote:
> You can copyright songs, but not individual musical notes.
>
> Likewise, snippets of code aren't copyrightable if they're below
> a certain "triviality size".

I don't pretend to be current on all the issues involved, but I've
always been under the impression that Linus has insisted that
binary-only drivers aren't derived works, with respect to the GPL.

If someone is worried they are, make all future headers state it
explicitly:

"Including this header in a Linux kernel module shall not be construed
to constitute a derived work."

--
Ross Vandegrift
ross@willow.seitz.com

A Pope has a Water Cannon.                               It is a Water Cannon.
He fires Holy-Water from it.                        It is a Holy-Water Cannon.
He Blesses it.                                 It is a Holy Holy-Water Cannon.
He Blesses the Hell out of it.          It is a Wholly Holy Holy-Water Cannon.
He has it pierced.                It is a Holey Wholly Holy Holy-Water Cannon.
He makes it official.      It is a Cannon Holey Wholly Holy Holy-Water Cannon.
Batman and Robin arrive.                                       He shoots them.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

