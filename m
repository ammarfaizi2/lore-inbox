Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286704AbRLVHnX>; Sat, 22 Dec 2001 02:43:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286705AbRLVHnO>; Sat, 22 Dec 2001 02:43:14 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7763 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S286703AbRLVHnE>; Sat, 22 Dec 2001 02:43:04 -0500
To: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure=2Ehelp=2E?=
In-Reply-To: <Pine.LNX.4.33.0112212050560.24550-100000@shell1.aracnet.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Dec 2001 00:41:27 -0700
In-Reply-To: <Pine.LNX.4.33.0112212050560.24550-100000@shell1.aracnet.com>
Message-ID: <m11yhnsnvc.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"M. Edward (Ed) Borasky" <znmeb@aracnet.com> writes:

> On 21 Dec 2001, H. Peter Anvin wrote:
> 
> > > Finally, Farhenheit units are smaller so that they make more convenient
> > > divisions: Eg.
> >
> > Bullsh*t.  They seem more natural to you because you're more used to
> > them.  Anyone who hasn't grown up on the system think that Fahrenheit
> > is the ultimate in lunacy.
> 
> Fahrenheit units were developed by a different process than Celsius, but
> they are both "natural". The Celsius scale is 0 = freezing point of
> water and 100 = boiling point of water. The Fahrenheit scale was
> developed less precisely -- 0 is approximately the freezing point of
> human blood, IIRC, and 100 is approximately body temperature (Fahrenheit
> may have had a fever :)).

32 Fahrenheit is the freezing point of water.
32 + 180 is the boiling point of water.
To avoid negatives an extra 32 degrees were added.
And we measure it in degrees because the designer of Fahrenheit was
thinking about how angles were measured when he designed the system.

Now measuring Celsius is in degrees is the cute one.

As for other topics in this thread.
12 is a nicer base than 10 simply because it has more factors.

And the US officially is on the metric system.  However usage for
common things hasn't changed over.  And no one has had the guts to
have a flag day, and kick out.

As for all of the mebibyte versus megabyte stuff.  While change is
awkward it seems much more comfortable to me if we change the expanded
for first.  And then put in the abbreviations.  Otherwise everyone
will think megabyte and write MiB, which helps little.

Thinking a megabyte is 1000000 bytes and a mebibyte is 1048576 bytes
is almost sane.  Of course the only way to be really clear would be to
have another term for a decimal megabyte, and just drop the old term
with it's nasty baggage.  Since we don't have that the problem will
continue on.  But having two terms at least lets us be precise.

Eric
