Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293412AbSCFJ30>; Wed, 6 Mar 2002 04:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293416AbSCFJ3P>; Wed, 6 Mar 2002 04:29:15 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:36110 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S293412AbSCFJ3A>; Wed, 6 Mar 2002 04:29:00 -0500
Message-ID: <3C85E113.C3B6B5B8@aitel.hist.no>
Date: Wed, 06 Mar 2002 10:27:47 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.5-dj2 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Petro <petro@auctionwatch.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SSSCA: We're in trouble now
In-Reply-To: <1015028463.2276.231.camel@thanatos> <87bse7nz8g.fsf@CERT.Uni-Stuttgart.DE> <20020304083055.GB21138@hh.idb.hist.no> <20020306044121.GI22934@auctionwatch.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petro wrote:

> > Don't be too sure about that.  If a "few" knows how to circumvent,
> > they'll release circumvention kits that anybody can use.
> > Few people can use a new buffer overflow exploit, much
> > more can use a rootkit.
> 
>     That will end when you get a tripwire like system on each system
>     that reports back to Microsoft/Apple when certain critical binaries
>     don't match.

There is a difference between a circumvention kit and a rootkit.
The rootkit modifies stuff in order to hide itself.
The circumvention kit doesn't.  It doesn't modify any
"official" binaries - it provides its own binary and lets
the other one sit there.

If this is impossible somehow - replace the tripwire-like system
as well as part of the circumvention kit.  More work,
still possible.  Or firewall the port used to report back
to vendors...

There is so many options.  They may try - they will fail.


Helge Hafting
