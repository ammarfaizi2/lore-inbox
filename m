Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285000AbRLUTNW>; Fri, 21 Dec 2001 14:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285013AbRLUTNM>; Fri, 21 Dec 2001 14:13:12 -0500
Received: from borg.org ([208.218.135.231]:44809 "HELO borg.org")
	by vger.kernel.org with SMTP id <S284998AbRLUTM5>;
	Fri, 21 Dec 2001 14:12:57 -0500
Date: Fri, 21 Dec 2001 14:12:57 -0500
From: Kent Borg <kentborg@borg.org>
To: lk@Aniela.EU.ORG
Cc: Mike Harrold <mharrold@cas.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        nknight@pocketinet.com, linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
Message-ID: <20011221141257.R3736@borg.org>
In-Reply-To: <20011221134150.O3736@borg.org> <Pine.LNX.4.33.0112212048230.4311-100000@ns1.Aniela.EU.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112212048230.4311-100000@ns1.Aniela.EU.ORG>; from lk@Aniela.EU.ORG on Fri, Dec 21, 2001 at 08:49:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2001 at 08:49:44PM +0200, lk@Aniela.EU.ORG wrote:
> If you would pay more attention, you can see that on most drives there is
> a small note that says: 1MB = 1000000 bytes. This is why the drive
> capacity is smaller than the manufacturer says.

So you are saying that my "12GB" drive is 12,000,000,000 bytes instead
of 12,884,901,888 bytes?  

The drive in the notebook I am typing on now seems to be neither.  If
I am doing arithmetic and reading hdparm output right, I think it is
12,072,517,632 bytes (smaller once formatted).  Not a very round
decimal number.

My point was that big round decimal numbers are rare in computers, so
why do we suddenly need big round decimal units for talking about
computers?

Disk drives have inherently binary capacities, the only reason to
quote their capacities in decimal was to make them look bigger.  I
don't see why we should have new units to make that easier.  This is
particularly ironic when disk manufacturers are so good at making them
bigger at a pace that has seriously out-paced Moore's Law.


-kb
