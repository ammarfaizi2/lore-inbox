Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262909AbSJAXqN>; Tue, 1 Oct 2002 19:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262911AbSJAXqM>; Tue, 1 Oct 2002 19:46:12 -0400
Received: from mta02ps.bigpond.com ([144.135.25.134]:44510 "EHLO
	mta02ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S262909AbSJAXqH>; Tue, 1 Oct 2002 19:46:07 -0400
Message-ID: <013501c269a7$3aba0680$0800000a@ValVenus>
From: "David McIlwraith" <quack@bigpond.net.au>
To: "Daniel Phillips" <phillips@arcor.de>
Cc: <linux-kernel@vger.kernel.org>
References: <006101c2699f$8087dfa0$0800000a@ValVenus> <E17wWIM-0006Gk-00@starship>
Subject: Re: [2.5.40] DAC960 broken?
Date: Wed, 2 Oct 2002 10:04:08 +1000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch for 2.5.38 works, albeit if you copy DAC960.[ch] from 2.5.38 to
drivers/block. The patch is broken in 2.5.40.

----- Original Message -----
From: "Daniel Phillips" <phillips@arcor.de>
To: "David McIlwraith" <quack@bigpond.net.au>;
<linux-kernel@vger.kernel.org>
Sent: Wednesday, October 02, 2002 9:19 AM
Subject: Re: [2.5.40] DAC960 broken?


> On Wednesday 02 October 2002 01:08, David McIlwraith wrote:
> > Is the DAC960 driver broken? I note that the maintainer is no longer
active,
> > and it does not compile.
> >
> > Is there patches to fix this problem?
>
> Dave Olien has a functional patch.  Look for his posts on this list.
>
> --
> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


