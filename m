Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264562AbRFMHGk>; Wed, 13 Jun 2001 03:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264564AbRFMHGa>; Wed, 13 Jun 2001 03:06:30 -0400
Received: from temp20.astound.net ([24.219.123.215]:14597 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S264562AbRFMHGK>; Wed, 13 Jun 2001 03:06:10 -0400
Date: Wed, 13 Jun 2001 00:06:09 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: bert hubert <ahu@ds9a.nl>
cc: Craig Lyons <craigl@promise.com>, linux-kernel@vger.kernel.org
Subject: Re: [craigl@promise.com: Getting A Patch Into The Kernel] (fwd)
In-Reply-To: <20010613084352.A7423@home.ds9a.nl>
Message-ID: <Pine.LNX.4.10.10106122350390.9509-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


No I would not take their code and apply it.
I might not even want to look at it.
All I want is the API rules to the signatures and we have them now.

We do not need their driver.

Next insults to linux in this form are unacceptable means of
communication.

*********
This support will also include a version of our FastCheck utility for
X-Windows. To start we will only support distribution versions of the
kernel. No test or beta kernels will be supported at this time. Promise
realizes that support could have come much sooner but as I started earlier
we are much more concerned with compatibility and quality rather than
rushing support to the market at the expense of the end user. Hopefully this
answers you immediate questions about our Linux support structure.
*********

Stating/Implying that Linux Maintainers do not care about "quality".

Oh it gets much worse, but I want to see if the sales for Promise have hit
hard enough to break their linux-unfriendly additude.  Mind you the came
begging for help because their sales are off, and I was willing to help on 
the terms of GPL/GNU and mine.  But GPL/GNU was to big to choke down.
When the sales hurt enough and they have not choice, I will reconsider.
Breathe, because you die before I change my position, if you are hold a
breath.

I do not trust Promise, and three years of their general arrogance is more
than enough.  Mind you that at one point I had two people in the San Jose
office that were friendly be they are now gone.  They got to close to
GPL/GNU and something happened.

Regards,

Andre Hedrick
Linux ATA Development

On Wed, 13 Jun 2001, bert hubert wrote:

> On Tue, Jun 12, 2001 at 11:22:56PM -0700, Andre Hedrick wrote:
> 
> > I do not want or need your company's patches, period.
> 
> That's just not true and you know it. If the patches were to be written in
> cooperation with you and of proper quality and license you would love them.
> 
> > I will not take or accept or approve of any dirty code that allows the a
> > poorly written binary driver that can not control its ISR and it
> > interferes irresponsiblily with the native ATA driver.
> 
> That's the real issue of course. Craig contacted you to find out what was
> wrong and you should explain to him what the problems are, and how he could
> solve them. Linus would accept patches written by Bill Gates if they were
> licensed right and coded properly, so I don't see why Promise should be an
> exception.
> 
> Never get angry at bad code. Only explain people why it's bad. At length if
> needed.
> 
> Craig:
> 
> > instead each disk is seen individually, and the users data cannot be
> > properly accessed. We have a patch that fixes this and are wondering if it
> > is possible to get this patch into the kernel, and if so, how this would be
> > done?
> 
> The procedure is to publish the patch publically and have people comment and
> try it. They will often find that your code is not up to par or does things
> in ways that do not please the kernel people. No evil is intended, it is
> just that the kernel developers are a choosy bunch. But given the right
> prodding they will tell you how you could change your code so that it is
> acceptable. Alternatively, people here might see what needs to be done from
> your patch, and do it themselves.
> 
> > I apologize if this is the incorrect e-mail to be making this request to. If
> > this is not the correct address to be posting this message, any assistance
> > as to where it should be directed would be greatly appreciated.
> 
> This was definitely the right email address :-) Mr Hedrick appears not to
> like your work and as he is prone to do, he explained so graphically. This
> happens. The main thing is to approach kernel coders from a technical
> standpoint - they are not interested in commercial pressures or deadlines.
> Get your technical people to talk to 'our' technical people and make sure
> that they realise that it should be done 'our way' (as it is 'our code')
> and things will go swimmingly.
> 
> > http:\\www.promise.com
> 
> Reversing those backslashes might aid your credibility here :-) If you ever
> feel that you don't understand these strange linux people, please contact me
> or some other people. It can be a weird country, especially coming from a
> marketing devision. Thanks for trying!
> 
> But do understand that no amount of prodding, cajoling or legal pressure
> will get any company anywhere. That's just not the way. As we say "It's the
> code, stupid!". Good luck!
> 
> Regards,
> 
> bert hubert
> 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -- 
> http://www.PowerDNS.com      Versatile DNS Services  
> Trilab                       The Technology People   
> 'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet


