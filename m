Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131391AbQK2X1f>; Wed, 29 Nov 2000 18:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132110AbQK2X1Z>; Wed, 29 Nov 2000 18:27:25 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:24842 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S131682AbQK2X1P>; Wed, 29 Nov 2000 18:27:15 -0500
Date: Wed, 29 Nov 2000 16:52:36 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "Henning P . Schmiedehausen" <hps@tanstaafl.de>
Cc: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Fasttrak100 questions...
Message-ID: <20001129165236.A9536@vger.timpanogas.org>
In-Reply-To: <8voa7g$d1r$1@forge.tanstaafl.de> <Pine.LNX.4.21.0011291152500.5109-100000@sol.compendium-tech.com> <20001129210830.J17523@forge.tanstaafl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001129210830.J17523@forge.tanstaafl.de>; from hps@tanstaafl.de on Wed, Nov 29, 2000 at 09:08:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2000 at 09:08:30PM +0100, Henning P . Schmiedehausen wrote:
> No.
> 
> If I modify the kernel or any other GPL software for my personal use
> and give it to no one, I am _not at all_ forced to make it public.
> 
> Only if I distribute a compiled kernel or any other program under GPL,
> then I must give also the sources on request (!) and may not put any
> restrictions on your redistribution of these sources. Only thing that
> you must obey is again the GPL.
> 
> I use heavily patched kernels with lots of inhouse-stuff on a regular
> base for my inhouse use and there is _no_ way for you to even get a
> glimpse at it.  I don't give this to anyone, it's all just my personal
> stuff.

Depending on the terms of your use of the code, the Copyright holder
can obtain an order compelling you to hand over the code from a 
State or US District Court Judge, if you are using it under the terms 
of the GPL and fail to provide the modifications upon request, and you
are shown to be "converting" business opportunities to your own
benefit with it, GPL or no.  

That being said, the party seeking the order would be required to show
irreparable harm, which in this case, could be shown (you stated you 
intend to act in bad faith and breach the terms of the license).  I do 
not believe a Copyright holder, as I understand the GPL, would be able 
to stop you from redistributing your changes and/or selling them.  The 
GPL would grant you this right.  However, the copyright holder
could obtain an order forcing your compliance to the license in the 
US (and even in some foreign countries, but not all), and could 
also simply sue you for "conversion", then issue a Subpeona Dues Tecum, and
obtain the code via discovery uver F.R.C.P./U.C.C.P., and you would
be ordered to produce it, or face criminal contempt charges.  

If there's a finding of bad faith (i.e. you knew you were violating 
the license and did it anyway), the judge could also hit you for 
punitive damages.

Actually you are part right and part wrong.  If the terms of the license
require to return "derivative works" (which I believe the GPL does), you
have an obligation to provide these changes upon request.  It's also
just plain old good manners.

:-)

Jeff

> 
> You can't force me to give you a copy of my blafoo driver until I
> chose to either release it to the public in which case I must put it
> under GPL as it contains GPLed code or distribute a binary version to
> a customer, which then in turn has the right to request the source
> from me and (after he got it, because I am bound by GPL to give it to
> him), distribute it freely as this right is granted to him by GPL.

You have balls a big as mine.  

> 
> I am even allowed to erase my sources without making them ever public.

> 
> Please read the GPL:
> 
> --- cut ---
> Activities other than copying, distribution and modification are not

modification >>> you're nailed.

:-)

Jeff

> covered by this License; they are outside its scope.  The act of
> running the Program is not restricted, and the output from the Program
> --- cut ---
> 
> I don't distribute the software. I just run it.
> 
> --- cut ---
>   2. You may modify your copy or copies of the Program or any portion
> of it, thus forming a work based on the Program, and copy and
> distribute such modifications or work under the terms of Section 1
> above, provided that you also meet all of these conditions:
> --- cut ---
> 
> I chose not to copy and distribute these modified programs which is
> perfectly covered by my license which I got when obtaining the
> sources.
> 
> Anything else would mean that I can send E-Mail to Linus Torvalds
> every five minutes and request a verbatim copy of his current hacking
> kernel tree as it is under GPL, which he is the forced to give to me
> because of the GPL. This would be utter nonsense.
> 
> 	Regards
> 		Henning
> 
> 
> On Wed, Nov 29, 2000 at 11:53:59AM -0800, Dr. Kelsey Hudson wrote:
> > On Sat, 25 Nov 2000, Henning P. Schmiedehausen wrote:
> > 
> > > No, it does not. Distributing does. You will never get this right. You
> > > can compile into your kernel anything you like as long as you don't
> > > give it away.
> > 
> > You are wrong: If you modify the kernel you have to make it available for
> > anyone who wishes to use it; that's also in the GPL. You can't add stuff
> > to it and then not distribute it, that's in violation.
> > 
> >  Kelsey Hudson                                           khudson@ctica.com 
> >  Software Engineer
> >  Compendium Technologies, Inc                               (619) 725-0771
> > ---------------------------------------------------------------------------     
> 
> -- 
> Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
> INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de
> 
> Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
> D-91054 Buckenhof     Fax.: 09131 / 50654-20   
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
