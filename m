Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129773AbRAESrK>; Fri, 5 Jan 2001 13:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131633AbRAESrA>; Fri, 5 Jan 2001 13:47:00 -0500
Received: from cambot.suite224.net ([209.176.64.2]:11275 "EHLO suite224.net")
	by vger.kernel.org with ESMTP id <S129773AbRAESqr>;
	Fri, 5 Jan 2001 13:46:47 -0500
Message-ID: <004101c07748$60a74720$9842b0d1@pittscomp.com>
From: "Matthew D. Pitts" <mpitts@suite224.net>
To: <Wayne.Brown@altec.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <862569CB.0060544C.00@smtpnotes.altec.com>
Subject: Re: Change of policy for future 2.2 driver submissions
Date: Fri, 5 Jan 2001 13:50:26 -0500
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


----- Original Message -----
From: <Wayne.Brown@altec.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Daniel Phillips <phillips@innominate.de>; Mark Hahn
<hahn@coffee.psychology.mcmaster.ca>; <linux-kernel@vger.kernel.org>
Sent: Friday, January 05, 2001 12:32 PM
Subject: Re: Change of policy for future 2.2 driver submissions


> On another subject, is all this new "testXX-preYY" stuff over now that
2.4.0 is
> out, and will we be going back to the standard x.y.z numbering scheme?  Or
is
> this another thing that's changed for good?  I really miss being able to
apply
> all the patches at once with linux/scripts/patchkernel.
>
> Wayne
>
Wayne,

The versions of patch-kernel included in 2.3/2.4 support extra version
information, so patches from Linus and others (i.e. Alan Cox) can be applied
if proper information is placed in the kernel Makefile.

Matthew D. Pitts
mpitts@suite224.net


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
