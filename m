Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282385AbRKXHIv>; Sat, 24 Nov 2001 02:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282386AbRKXHIe>; Sat, 24 Nov 2001 02:08:34 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:47620
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S282387AbRKXHIP>; Sat, 24 Nov 2001 02:08:15 -0500
Date: Fri, 23 Nov 2001 23:06:23 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Martin Eriksson <nitrax@giron.wox.org>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: IDE is still crap.. or something
In-Reply-To: <017901c17459$5624acc0$0201a8c0@HOMER>
Message-ID: <Pine.LNX.4.10.10111232239100.32407-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2001, Martin Eriksson wrote:

> > > any of the -c -u -m -W settings in hdparm. I even applied the 2.4.14 IDE
> > > patch (after fixing the rejects) but no go.

Mr. Martin Eriksson,

As for your subject -- "IDE" died a long time ago, but since it died
before you entered university, I am not at all surprized.  Now as for
jumping on the case of the talented Mr. Marcelo Tosatti.  He has not found
it neccessary to enter university at this time, as he could likely teach
the content scheduled in the next year to you.

Why are you doing thoughtless things like overriding the ruleset for
optimizing the HOST/Device pair?  I seriously doubt that you know the
history of those option?  Of the lot, one of them is retired as of ATA-2;
however it still is optional for a while.  The other is foolish in most
cases unless dealing with ATA-2 hardware, or have audio driver problems.
The next is settable by the kernel if you allow it to do the work for you.
The last is also set by the kernel, should you allow it to operate.  There
is no valid reason for you to do anything w/ hdparm.

Now this is a global reply to your list of rants.  Now if you can not
merge patches and understand what is going on, then please keep the noise
down.  Next time please have some credablity when you attempt to make
grand pontifications of code quality in Linux.  Lastly you were not to be
a target for everyones entertainment but this is where you have come.

Regards,

Andre Hedrick
Linux ATA Development
Linux Disk Certification Project


