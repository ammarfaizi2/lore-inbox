Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289238AbSANNqB>; Mon, 14 Jan 2002 08:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289236AbSANNpv>; Mon, 14 Jan 2002 08:45:51 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:44173 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289238AbSANNpd>; Mon, 14 Jan 2002 08:45:33 -0500
Date: Mon, 14 Jan 2002 15:44:34 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jim Studt <jim@federated.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with ServerWorks CNB20LE and lost interrupts
In-Reply-To: <Pine.GSO.3.96.1020114130649.10091E-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.4.33.0201141541540.9075-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Maciej W. Rozycki wrote:
>  Why to code complicated workarounds for broken firmware?  It's so easy to
> fix, so either bother the vendor for a fix or replace the system with a
> sane one.  Reading and understanding the Intel's MP spec is a day or at
> most two worth of man's work.  I wouldn't trust the vendor that refuses to
> invest in a product even that little.

You may have noticed the great deal of "hacks" which people have put into
the kernel over the years to get it to work with the imperfect world of
hardware. It makes you wonder wether we should waste our time supporting
broken hardware... Then again if we didn't we'd only run on 0.1% of the
boxes out there ;) But... i'm in no way advocating for adding more
kludges.

Regards,
	Zwane Mwaikambo


