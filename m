Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280310AbRJaRJM>; Wed, 31 Oct 2001 12:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280307AbRJaRIz>; Wed, 31 Oct 2001 12:08:55 -0500
Received: from 158-VALL-X6.libre.retevision.es ([62.83.214.158]:1408 "EHLO
	ragnar-hojland.com") by vger.kernel.org with ESMTP
	id <S280306AbRJaRId>; Wed, 31 Oct 2001 12:08:33 -0500
Date: Tue, 30 Oct 2001 03:18:44 +0100
From: Ragnar Hojland Espinosa <ragnar@ragnar-hojland.com>
To: Petr Baudis <pasky@pasky.ji.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LPP (was: The new X-Kernel !)
Message-ID: <20011030031844.A1272@ragnar-hojland.com>
In-Reply-To: <20011021220346.D19390@vega.digitel2002.hu> <15vQtM-22TOdsC@fmrl02.sul.t-online.com> <20011022022839.A8452@unthought.net> <15va3i-0cRXvcC@fmrl00.sul.t-online.com> <20011022103411.A17996@crystal.2d3d.co.za> <20011022022442.A467@ragnar-hojland.com> <20011023225003.E14850@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011023225003.E14850@pasky.ji.cz>; from pasky@pasky.ji.cz on Tue, Oct 23, 2001 at 10:50:03PM +0200
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2001 at 10:50:03PM +0200, Petr Baudis wrote:

Sorry for the late reply Petr, I'm a bit swamped here..

> > Even better paralelism:  What do people run, strace ls or ls?
> With strace ls, output of ls is not very usable. So this doesn't match.

Fine.  rm then.  perfectly useable.

> > Please reread what you have written.  Now run dmesg.  Do you see messages
> > telling you what's wrong there?  No?  Okay.. So what is it telling you?
> With hiding of messages during boot, you won't ever have an idea to _run_
> the dmesg!

I don't understand why you are saying that (in this context)

> They can also help to presume problems on the horizon and then seeking for
> the cause of them... one might say... ah, wait a minute, now i remember,
> during bootup i glanced there, and there was something about DMA errors,
> wtf is that? can't it be a problem?

Sure.  But what is easier, to glance "something" about DMA errors among all
the other usual chatter, or just by itself?  That's something the different
KERN_ could do for us. 

> > Now picture a quite iliterate user with a messages, and a boot problem..
> > what will he say in the majority of the cases?  I'll tell you: "my linux 
> > wont boot" / "my linux crashed", and if you ask what was on the screen to 
> > "oh.. dunno.. the lines it uses to print..", so messages wouldnt make a
> > difference.  If people dont use to read error/message dialogs, are you
> > seriously expecting them to read and understand that "text thingie"?

> and when they hide them, they will say "it didn't do anything. dunno where
> it stopped. to run it with li..what? loot_virboss:zero? excuse me?"

*laugh* true :)  Thats what il-user friendly tools are for.  I'm sure theres
some gtk/gnome/kde gui thing to select how to boot next time.  And if there
isn't I'm sure you realize its easy to do.

> as someone said here, this is also a psychological issue, the feeling of
> common secret knowledge, the feeling of speciality, the cool matrix-like
> look which make you look as geek and expert, the mysterious messages which

Soo.. bob goes to alice, and sees the usual messages.  Or, bob goes to alice:
"wow, how did you get all those mysterious messages from?"

Not only hiding would enhance this factor you are alluding(sp?), but it
would also help the people who are "impressed" by them.

> that you don't understand it? it looks cool so it is good :P and you said
> they won't even read it, so they won't have a feeling of informations
> overhead, so they won't hate or fear the computer, just like it that it
> is willing to tell them what is going on, if they would ever want to
> listen...

Theres people who don't want to.  Mostly because for normal operation they
don't have to, and because they aren't willing to commit enough time/effort
to figure out what is going on.  If their car doesn't work, they take it to
a mechanic, they don't try to figure it out by themselves.  They know and
only want to drive it.

-- 
____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  | (www.brainbench.com)
   U     chaos and madness await thee at its end."
