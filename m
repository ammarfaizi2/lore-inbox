Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130502AbQJaWCE>; Tue, 31 Oct 2000 17:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130515AbQJaWBy>; Tue, 31 Oct 2000 17:01:54 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:3595 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130502AbQJaWBn>; Tue, 31 Oct 2000 17:01:43 -0500
Message-ID: <39FF4061.D47E59CF@timpanogas.org>
Date: Tue, 31 Oct 2000 14:57:53 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Pavel Machek <pavel@suse.cz>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <Pine.LNX.4.21.0010312229030.15159-100000@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo Molnar wrote:
> 
> On Tue, 31 Oct 2000, Jeff V. Merkey wrote:
> 
> > It relies on an anomoly in the design of Intel's cache controllers,
> > and with memory based applications, I can get 120% scaling per
> > procesoor by jugling the working set of executable code cached accros
> > each processor.  There's sample code with this kernel you can use to
> > verify....
> 
> FYI, this is a very old concept and a scalability FAQ item. It's called
> "sublinear scaling", and SGI folks have already published articles about
> it 10 years ago.

Ingo,

You don't even know what it is enough to comment intelligently.  You can
write the patent office and obtain a copy.  The patent is currently in
dispute between Novell and several other companies over S&E ownership,
and there's a court hearing scheduled to resolve it (lukily I don't have
to deal with this one).  Nice thing about being an inventor, though, is
I have rights to it, no matter who ends up with the S&E assignment.
(dogs fights over a bone ...).

Jeff

> 
>         Ingo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
