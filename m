Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285132AbRLFNMC>; Thu, 6 Dec 2001 08:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285129AbRLFNLv>; Thu, 6 Dec 2001 08:11:51 -0500
Received: from web13905.mail.yahoo.com ([216.136.175.68]:60680 "HELO
	web13905.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S285130AbRLFNLj>; Thu, 6 Dec 2001 08:11:39 -0500
Message-ID: <20011206131138.81573.qmail@web13905.mail.yahoo.com>
Date: Thu, 6 Dec 2001 05:11:38 -0800 (PST)
From: Jorge Carminati <jcarminati@yahoo.com>
Subject: Re: Kernel freezing....
To: linux-kernel@vger.kernel.org
In-Reply-To: <3C0EDAEE.6080608@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

François Wrote:

> okay, I kinda see the problem now. Would you consider using a
> 2.4.16 kernel, optimized for i386, and compiled with gcc 2.95.3 ?
> If that solves the problem, you might want
> to compile your kernel for i586 ; if that works
> again, you might want to try optimizing for K6.
> Don't go higher than that though ; optimizing for i686 or
> Athlon will break.
> And please don't use another gcc ; 2.95.3 is the most reliable
> right now, eventhough "some" 2.96 seem to work fine, but I suspect
> they might not, in your case.


Ok François, I´ll try it tonight, first attempt compiled for i386.
Tomorrow I´ll post the results.


> 
> the key is :
> 
> (duron or athlon) and via and (PSU sloppiness or "not so high grade"
> RAM),
> 
> which is the case in too many notebooks.
> 

Ok, you spend U$ 1800 (that´s the price here) for a "not so high grade"
Compaq memory... sounds lamentable

>PS : please, please keep me informed, I think I'm uncovering an
unknown

Sure I´ll do.

>bug at the hardware level, but I'm not sure *yet*. FYI it's not a
>blocking problem, at least when running Linux, it only keeps you
>from using the Athlon/Duron at full speed (i.e. full kernel/compiler
>optimizations).


Anyway, I installed a fresh Red Hat 7.2 copy, which doesn´t comes
optimized for AMD, but the freeze is there...

Regards,
Jorge Carminati.

__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com
