Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAXHE4>; Wed, 24 Jan 2001 02:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129764AbRAXHEr>; Wed, 24 Jan 2001 02:04:47 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:5125 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129431AbRAXHEl>;
	Wed, 24 Jan 2001 02:04:41 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101240701.f0O71OE110437@saturn.cs.uml.edu>
Subject: Re: Bug in ppp_async.c
To: paulus@linuxcare.com.au
Date: Wed, 24 Jan 2001 02:01:24 -0500 (EST)
Cc: l_indien@magic.fr, jma@netgem.com, callahan@maths.ox.ac.uk,
        jfree@sovereign.org, linux-kernel@vger.kernel.org
In-Reply-To: <14958.25201.508164.388346@diego.linuxcare.com.au> from "Paul Mackerras" at Jan 24, 2001 04:04:49 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras writes:
> Jo l'Indien writes:

>> I found a bug in the 2.4.1-pre10 version of ppp_async.c
>>
>> In fact, a lot of ioctl are not supported any more,
>> whih make the pppd start fail.
>
> I'll bet you're using an old pppd.  You need version 2.4.0 of pppd,
> available from ftp://linuxcare.com.au/pub/ppp/, as documented in the
> Documentation/Changes file.

Even Red Hat 7 only has the 2.3.11 version.

The 2.4.xx series is supposed to be stable. If there is any way
you could add a compatibility hack, please do so.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
