Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263765AbREYP2z>; Fri, 25 May 2001 11:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263766AbREYP2p>; Fri, 25 May 2001 11:28:45 -0400
Received: from node16.benchmk.com ([207.180.73.116]:18436 "EHLO noop.")
	by vger.kernel.org with ESMTP id <S263765AbREYP2a>;
	Fri, 25 May 2001 11:28:30 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI - console problems 2.4.4
In-Reply-To: <m3ae46fzgs.fsf@yahoo.com> <20010523163231.B33@toy.ucw.cz>
From: Nick Papadonis <npapadon@yahoo.com>
Organization: None
X-Face: 01-z%.O)i7LB;Cnxv)c<Qodw*J*^HU}]Y-1MrTwKNn<1_w&F$rY\\NU6U\ah3#y3r<!M\n9
 <vK=}-Z{^\-b)djP(pD{z1OV;H&.~bX4Tn'>aA5j@>3jYX:)*O6:@F>it.>stK5,i^jk0epU\$*cQ9
 !)Oqf[@SOzys\7Ym}:2KWpM=8OCC`
Content-Type: text/plain; charset=US-ASCII
Date: 25 May 2001 11:27:15 -0400
In-Reply-To: <20010523163231.B33@toy.ucw.cz> (Pavel Machek's message of "Wed, 23 May 2001 16:32:32 +0000")
Message-ID: <m34ru95u0c.fsf@yahoo.com>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Hi!
> 
> > Is anyone having problems with ACPI causing console problems in kernel
> > 2.4.4 w/ Intel's patches?   When watching my system boot over the
> > serial console, things work fine.  When looking at my VAIO-FX140's
> > LCD, my console no longer updates after ACPI starts initializing _INI methods.
> > 
> > I am able to login and shutdown without my LCD echoing back.
> > 
> > Here is my output from the serial port:
> 
> Is this vanilla 2.4.4? I somehow doubt that.
> 								Pavel
Yes it is, however with Intel's ACPI patches.

I suspect there is a problem with the VGA adapter + ACPI.  I haven't
been able to use ACPI at all because of this.

Is there ANYONE out there that has a VAIO?  It would be nice if
someone could reproduce this too.

- Nick


