Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276052AbRJVPaa>; Mon, 22 Oct 2001 11:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276708AbRJVPaU>; Mon, 22 Oct 2001 11:30:20 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:59048 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S276052AbRJVPaN>;
	Mon, 22 Oct 2001 11:30:13 -0400
Message-ID: <3BD43BA5.B9E8E557@candelatech.com>
Date: Mon, 22 Oct 2001 08:30:45 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Bird <tbird@lineo.com>
CC: no To-header on input 
	<"unlisted-recipients:;;"@www.candelatech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Input on the Non-GPL Modules - legal nonsense
In-Reply-To: <E15v4Dz-0002VM-00@the-village.bc.nu> <3BD1F5CC.20BF3F20@candelatech.com> <3BD438ED.360D0007@lineo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Bird wrote:
> 
> Ben Greear wrote:
> >
> > Alan Cox wrote:
> > >
> > > > What prevents the author of a non-GPL module who needs access to a
> > > > GPL-only symbol from writing a small GPLed module which imports the
> > > > GPL-only symbol (this is allowed, because the small module is GPL),
> > > > and exports a basically identical symbol without the GPL-only
> > > > restriction?
> > >
> > > The fact that it ends up GPL'd to be linked (legal derivative work sense)
> > > to the GPL'd code so you can link it to either but not both at the same time
> >
> > If you own the copyright to the small shim GPL piece, can anyone else
> > take legal action on your part?  If not, then all you have to do is not
> > sue yourself for the double linkage and no one else can sue you either....
> 
> I keep hearing this type of reasoning.  It flat-out doesn't work
> this way in the legal system.  This is similar to arguing that
> you didn't really stab someone if you threw the knife instead
> of holding it. ("But your honor, once the knife left my hand
> it really wasn't under my control...")

I'm not advocating this as a good thing to do, but I am curious:  Can someone
else take action against this?  I hope the answer is yes.  This
whole thing begins to look like MS's attempts at securing digital music:
there are just too many ways around it.  Either way,
I've had my say on this topic...and will let it RIP.

Ben

> 
> If your actions bring about the result, whether
> directly or indirectly, you are legally liable for the
> consequences.
> ____________________________________________________________
> Tim Bird                                  Lineo, Inc.
> Senior VP, Research                       390 South 400 West
> tbird@lineo.com                           Lindon, UT 84042
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
