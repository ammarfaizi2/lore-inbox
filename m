Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131488AbRADUHQ>; Thu, 4 Jan 2001 15:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132548AbRADUG7>; Thu, 4 Jan 2001 15:06:59 -0500
Received: from nrg.org ([216.101.165.106]:23073 "EHLO nrg.org")
	by vger.kernel.org with ESMTP id <S131315AbRADUGk>;
	Thu, 4 Jan 2001 15:06:40 -0500
Date: Thu, 4 Jan 2001 12:06:38 -0800 (PST)
From: Nigel Gamble <nigel@nrg.org>
Reply-To: nigel@nrg.org
To: ludovic fernandez <ludovic.fernandez@sun.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.0-prerelease: preemptive kernel.
In-Reply-To: <3A53D863.53203DF4@sun.com>
Message-ID: <Pine.LNX.4.05.10101041157540.4778-100000@cosmic.nrg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, ludovic fernandez wrote:
> For hackers,
> The following patch makes the kernel preemptable.
> It is against 2.4.0-prerelease on for i386 only.
> It should work for UP and SMP even though I
> didn't validate it on SMP.
> Comments are welcome.

Hi Ludo,

I didn't realise you were still working on this.  Did you know that
I am also?  Our most recent version is at:

ftp://ftp.mvista.com/pub/Area51/preemptible_kernel/

although I have yet to put up a 2.4.0-prerelease patch (coming soon).
We should probably pool our efforts on this for 2.5.

Cheers,
Nigel

Nigel Gamble                                    nigel@nrg.org
Mountain View, CA, USA.                         http://www.nrg.org/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
