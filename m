Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288216AbSAHSfp>; Tue, 8 Jan 2002 13:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288218AbSAHSfe>; Tue, 8 Jan 2002 13:35:34 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:41204 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S288216AbSAHSfQ>; Tue, 8 Jan 2002 13:35:16 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200201081738.g08Hcw125981@schroeder.cs.wisc.edu> 
In-Reply-To: <200201081738.g08Hcw125981@schroeder.cs.wisc.edu>  <20011230122500.E859-100000@gerard> <WHITEvJ1xKjtgZe0J64000008b1@white.pocketinet.com> <20020108181224.M5235@khan.acc.umu.se> 
To: Nick LeRoy <nleroy@cs.wisc.edu>
Cc: Nicholas Knight <nknight@pocketinet.com>,
        =?iso-8859-1?q?G=E9rard=20Roudier?= <groudier@free.fr>,
        Linux <linux-kernel@vger.kernel.org>
Subject: Re: Bounce from andre@linuxdiskcert.org 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Jan 2002 18:35:00 +0000
Message-ID: <31539.1010514900@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


nleroy@cs.wisc.edu said:
>  It sure would be nice if they'd send you an email informing you that
> your  site has an open relay, and if it's not corrected within, say, 1
> week, you'll  be put on the black list.  These sites also obviously
> have tests for checking  for open relays, also.  The administrator of
> said site should be allowed  access to these same tests to aid in
> diagnosing and solving the problem.

I don't understand your complaint - is there any particular stupidity you
think your own mail server might be guilty of, for which you are not capable
testing for yourself _before_ you get blacklisted? Or indeed for which any
responsible admin wouldn't test automatically as part of the process of
commissioning a new system?

Some blacklists do have a policy of warning the owners of offending sites
before actually adding the site to the list, and postponing the addition for
as long as the admin says that they're working on fixing the brokenness.
This gets abused.

The list of offences for which you'll get blacklisted isn't very large. If
you can't manage to set up a well-behaved system without external
assistance, you shouldn't be running it in the first place.

--
dwmw2


