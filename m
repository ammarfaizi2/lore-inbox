Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292688AbSCOOxM>; Fri, 15 Mar 2002 09:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292700AbSCOOxC>; Fri, 15 Mar 2002 09:53:02 -0500
Received: from mout04.kundenserver.de ([195.20.224.89]:561 "EHLO
	mout04.kundenserver.de") by vger.kernel.org with ESMTP
	id <S292688AbSCOOwq>; Fri, 15 Mar 2002 09:52:46 -0500
Message-ID: <3C920ABB.6E17E324@ngforever.de>
Date: Fri, 15 Mar 2002 07:52:43 -0700
From: Thunder from the hill <thunder@ngforever.de>
Organization: The LuckyNet Administration
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.8-26mdk i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Martin Eriksson <nitrax@giron.wox.org>
Subject: Re: HPT370 RAID-1 or Software RAID-1, what's "best"?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Luigi Genoni wrote:
> HPT370 IDE Raid is not really an hardware raid.
> It is a software Raid, since Linux does not use tha raid implementation
> that comes with the BIOS, but it uses softwareraid.
That doesn't prevent me from saying that real hardware raid might be
better. But is the thing you wish to say that there's no difference, or
what?

Alan Cox wrote:
> The raid rebuild time is identical for pretty much any set up. With the
> softraid its intentionally defaulting to a low fraction of I/O bandwidth
> so it doesnt disrupt normal operation.
I experienced it took at about twice the time for a rebuild. I don't
exactly remember the test results, and they aren't available to me until
Monday. If you're interested...
Maybe things have changed a lot since last year, when I did the tests.

> Also as far is his question goes - both are software raid
See above.

Thunder
-- 
begin-base64 755 -
IyEgL3Vzci9iaW4vcGVybApteSAgICAgJHNheWluZyA9CSMgVGhlIHNjcmlw
dCBvbiB0aGUgbGVmdCBpcyB0aGUgcHJvb2YKIk5lbmEgaXN0IGVpbiIgLgkj
IHRoYXQgaXQgaXNuJ3QgYWxsIHRoZSB3YXkgaXQgc2VlbXMKIiB2ZXJhbHRl
dGVyICIgLgkjIHRvIGJlIChlc3BlY2lhbGx5IG5vdCB3aXRoIG1lKQoiTkRX
LVN0YXIuXG4iICA7CiRzYXlpbmcgPX4Kcy9ORFctU3Rhci9rYW5uXAogdW5z
IHJldHRlbi9nICA7CiRzYXlpbmcgICAgICAgPX4Kcy92ZXJhbHRldGVyL2Rp
XAplIExpZWJlL2c7CiRzYXlpbmcgPX5zL2Vpbi8KbnVyL2c7JHNheWluZyA9
fgpzL2lzdC9zYWd0LC9nICA7CiRzYXlpbmc9fnMvXG4vL2cKO3ByaW50Zigk
c2F5aW5nKQo7cHJpbnRmKCJcbiIpOwo=
====
Extract this and see what will happen if you execute my
signature. Just save it to file and do a
> uudecode $file | perl
