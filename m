Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261738AbREURjj>; Mon, 21 May 2001 13:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261747AbREURj3>; Mon, 21 May 2001 13:39:29 -0400
Received: from node17.benchmk.com ([207.180.73.117]:13573 "EHLO noop.")
	by vger.kernel.org with ESMTP id <S261738AbREURjN>;
	Mon, 21 May 2001 13:39:13 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: npapadon@yahoo.com (Nick Papadonis), linux-kernel@vger.kernel.org
Subject: Re: ACPI - console problems 2.4.4
In-Reply-To: <E151sPS-0000Sf-00@the-village.bc.nu>
From: Nick Papadonis <npapadon@yahoo.com>
Organization: None
X-Face: 01-z%.O)i7LB;Cnxv)c<Qodw*J*^HU}]Y-1MrTwKNn<1_w&F$rY\\NU6U\ah3#y3r<!M\n9
 <vK=}-Z{^\-b)djP(pD{z1OV;H&.~bX4Tn'>aA5j@>3jYX:)*O6:@F>it.>stK5,i^jk0epU\$*cQ9
 !)Oqf[@SOzys\7Ym}:2KWpM=8OCC`
Content-Type: text/plain; charset=US-ASCII
Date: 21 May 2001 13:37:25 -0400
In-Reply-To: <E151sPS-0000Sf-00@the-village.bc.nu> (Alan Cox's message of "Mon, 21 May 2001 17:19:54 +0100 (BST)")
Message-ID: <m34ruefvsa.fsf@yahoo.com>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > Is anyone having problems with ACPI causing console problems in kernel
> > 2.4.4 w/ Intel's patches?   When watching my system boot over the
> > serial console, things work fine.  When looking at my VAIO-FX140's
> > LCD, my console no longer updates after ACPI starts initializing _INI methods.
> 
> Generally a good rule is 'dont bother with ACPI'. But do let Andrew Grover
> know how it fails on your box
> 
My VAIO doesn't support APM. :(

I was trying to understand the call path on _INIT.  Hopefully with
some printk's I can track down the problem.

Any direction or areas for me to examine?  Thanks.

-- 
Nick
PGP KEY: http://www.coelacanth.com/~nick/npapadon.public.asc
