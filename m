Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263854AbRFIWJk>; Sat, 9 Jun 2001 18:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263863AbRFIWJb>; Sat, 9 Jun 2001 18:09:31 -0400
Received: from mpdr0.chicago.il.ameritech.net ([206.141.239.142]:42921 "EHLO
	mailhost.chi.ameritech.net") by vger.kernel.org with ESMTP
	id <S263854AbRFIWJN>; Sat, 9 Jun 2001 18:09:13 -0400
Message-ID: <3B229E95.F7E85C90@ameritech.net>
Date: Sat, 09 Jun 2001 17:09:25 -0500
From: watermodem <aquamodem@ameritech.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <mikeg@wen-online.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregistertable
In-Reply-To: <Pine.LNX.4.33.0106071747460.463-100000@mikeg.weiden.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> 
> On Thu, 7 Jun 2001, watermodem wrote:
> 
> > "David S. Miller" wrote:
> > >
> > > George Bonser writes:
> > >  > There is, of course, one basic problem with that argument. While you can say
> > >  > (and probably rightly so) that such a change would not be included in Linus'
> > >  > kernel, I think anyone is allowed to post a patch that might make it
> > >  > possible to add protocols as modules. If anyone chooses to use it is each
> > >  > individual's decision but you could not prevent ACME from creating a patch
> > >  > that allows protocol modules as long as they distributed the patch. Also,  I
> > >  > know that you are allowed to distribute proprietary modules in binary form
> > >  > but are there any restrictions on what function these modules can perform?
> > >  > I don't remember seeing any such restrictions.
> > >
> > > People can post whatever patches which do whatever, sure.
> > > But this isn't what matters.
> > >
> > > What matters is the API under which a binary-only module may interface
> > > to the kernel.  Linus specifies that only the module exports in his
> > > tree fall into this API.
> > >
> > > As I stated in another email, the allowance of binary-only kernel
> > > modules is a special exception to the licensing of the kernel made by
> > > Linus.  The GPL by itself, does not allow this at all.
> > >
> > > Later,
> > > David S. Miller
> > > davem@redhat.com
> >
> > David,
> >
> >    What is your real problem with La Monte's Code.
> >    I don't buy your more "blessed than thou" argument.
> >    It is a typical response one normally sees in large
> >    organizations from folk with "empires" to protect.
> >    Coming from the "land of warring tribes" firm it is
> >    a attitude I have seen often.  My response is take
> >    a vacation, chill out and reassess.
> 
> What words would you like to put in his mouth to replace those he used?
> 
>         -Mike
No words.....  Just suggesting to calm down for awhile before getting
into a flame-war.  I am old enough to know that nothing is lost by
considering your words before painting yourself into a corner you may
not want to occupy in the future.

He is discussing a theme with legal implications. (Legal and Slow tended
to be intertwined)  I know what his position in the linux kernel
hierarchy is, and if he were in a corporation with that position he
could just say NO without any reason.  But, linux development is
portrayed as something "open" and "of the people" not a closed corporate
offering.  Now, if that is not the case, then just take out all the
flowery words from the license and replace it with the unstated but
defacto communist motto "What's mine is mine What's yours is mine!". 
Then you have the Communist Linux vs the Capitalist M$.  Definitely
polarizes issues but doesn't buy anything with folks who just want to
run a stable computer and not make it a political statement.


> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
