Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264021AbRFMPxE>; Wed, 13 Jun 2001 11:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264023AbRFMPwy>; Wed, 13 Jun 2001 11:52:54 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:34432 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S264021AbRFMPwi>; Wed, 13 Jun 2001 11:52:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Andre Hedrick <andre@linux-ide.org>, bert hubert <ahu@ds9a.nl>
Subject: Re: [craigl@promise.com: Getting A Patch Into The Kernel] (fwd)
Date: Wed, 13 Jun 2001 06:51:54 -0400
X-Mailer: KMail [version 1.2]
Cc: Craig Lyons <craigl@promise.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10106122350390.9509-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10106122350390.9509-100000@master.linux-ide.org>
MIME-Version: 1.0
Message-Id: <01061306515403.00703@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 June 2001 03:06, Andre Hedrick wrote:
> No I would not take their code and apply it.
> I might not even want to look at it.

Well, you're maintainer and I'm obviously not, but it's nice to hear you've 
kept an open mind on this issue. :)

> All I want is the API rules to the signatures and we have them now.
>
> We do not need their driver.

Reinventing the wheel can be fun.  Richard Stallman's been doing that for 
years since he refuses to take any patch where he can't physically track down 
the author and make them sign a piece of paper handing the copyright over to 
the Free Software Foundation.  (He's got a file cabinet full of them so he'll 
have unassailable standing in case he ever has to sue anybody to enforce the 
GPL on GNU code.)

Of course the unfortunate side effect of this is that the GNU project stalled 
in the late 1980's, and this whole "Linux" think forked off of it and took 
over instead, in large part because there was just too much friction getting 
patches through the maintainer bottleneck, while Linus would accept anything 
from anybody.  (Linus sucked all the developers away from comp.os.minix for 
the same reason.)  But oh well.

> Next insults to linux in this form are unacceptable means of
> communication.
>
... insult omitted
>
> Stating/Implying that Linux Maintainers do not care about "quality".

"Quality" is a loaded word in marketing circles, due to ISO nine zillion and 
the sickening-sigma stuff and all that.  I always think of it in terms of 
"the most prominent qualities of this product are that it smells bad and 
tends to explode without warning.  Now wrap that up in flowers and make it 
sound good."  And off the marketing droids go...

You are aware that you were speaking to a marketing person from Promise, 
correct?  (He admitted it and everything.  We didn't even have to use 
thumbscrews.  Kind of a waste to get them all out and oiled and everything in 
that case...)

> Oh it gets much worse, but I want to see if the sales for Promise have hit
> hard enough to break their linux-unfriendly additude.

The dude came hat in hand into the linux-kernel mailing list asking how he 
could play nice with us, (apparently honestly not knowing,) and you bit his 
head off.

I don't think sales have hit hard enough to overcome THAT just yet.  But I 
could be wrong...

> Mind you the came begging for help because their sales are off, and I was 
> willing to help on the terms of GPL/GNU and mine.  But GPL/GNU was to big 
> to choke down.

Okay, THERE is the problem.  Halfway through the message.  Why not start with 
that next time?

If the problem is that the code will not be made available under the GPL, 
then of course that IS an insurmountable problem for getting it included in 
the kernel.  But it's entirely possible that our marketing friend didn't know 
that.  It's entirely possible he doesn't know what the GPL -IS-.  (If you've 
been sharing a private conversation with him that hasn't been CC'd to the 
list, than obviously I could be wrong about this...)

> When the sales hurt enough and they have not choice, I will reconsider.

No, hopefully THEY will reconsider.  You couldn't get Linus to accept non-gpl 
code either.

> Breathe, because you die before I change my position, if you are hold a
> breath.
>
> I do not trust Promise, and three years of their general arrogance is more
> than enough.  

I honestly doubt that the suit who just wandered through has a clue what the 
GPL is.  He's not a lawyer, and he doesn't write free software.  If he really 
was trying to help, and he was new to this, woudn't it be a nice first 
impression to clearly say "this licensing issue is blocking the inclusion of 
your code" so he knows what the problem is rather than "we're biased against 
promise, so we're going to pick on you and call you names?"

> Mind you that at one point I had two people in the San Jose
> office that were friendly be they are now gone.

If you've approached every new person from promise this way ever since, I'm 
not exactly suprised you haven't met more like them.  (I honestly hope that 
the previous sentence was a harsh and unfair assessment, and that you haven't 
been doing that.)

No corporation is truly a monolithic entity.  It's just a bunch of disjointed 
individuals who spend a lot of time in meetings filling out forms.  You can 
deal with them as a faceless professional with a known set of duties, or you 
can try to deal with them as a human being.

(Either way has been known to work, a bit like having two interfaces for the 
same object in Java.  I learned that working at IBM.  Plus the concepts of 
plausible deniability, least expected effort, a sort of judo approach to 
political infighting, that forgiveness is an order of magnitude easier to get 
than permission because punishing you takes effort, turning uncertainty to 
your advantage through the power of procrastination, and that everything I've 
seen so far in dilbert is less than 5% off from reality in the Fortune 500.  
Then I got the heck out of there and joined a six person start-up.)

> Regards,
>
> Andre Hedrick
> Linux ATA Development

Rob
Random geek without standing in this issue, who readily admits it but 
comments anyway.
