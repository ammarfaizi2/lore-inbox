Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbVJEWfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbVJEWfh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 18:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbVJEWfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 18:35:37 -0400
Received: from free.hands.com ([83.142.228.128]:64950 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S1030393AbVJEWfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 18:35:36 -0400
Date: Wed, 5 Oct 2005 23:35:20 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Request for starting a LVML (was: Re: what's next for the linux kernel?)
Message-ID: <20051005223520.GM10538@lkcl.net>
References: <mail.linux.kernel/20051003203037.GG8548@lkcl.net> <05Oct4.173802edt.33143@gpu.utcc.utoronto.ca> <20051005120727.GV10538@lkcl.net> <20051005123113.GO3511@suse.de> <20051005133549.GB10538@lkcl.net> <20051005134041.GR3511@suse.de> <20051005152935.GE10538@lkcl.net> <20051005155138.GJ3511@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051005155138.GJ3511@suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 05:51:39PM +0200, Jens Axboe wrote:
> On Wed, Oct 05 2005, Luke Kenneth Casson Leighton wrote:
> > On Wed, Oct 05, 2005 at 03:40:43PM +0200, Jens Axboe wrote:
> > > On Wed, Oct 05 2005, Luke Kenneth Casson Leighton wrote:
> > > > On Wed, Oct 05, 2005 at 02:31:14PM +0200, Jens Axboe wrote:
> > > > 
> > > > > [i know better criticism and accusations deleted and not commented on]
> > > > 
> > > > > Why is that so hard to understand? Succesful contributions start at the
> > > > > technical level, always have.
> > > >  
> > > >  then we will have to agree to disagree, because i believe that
> > > >  successful contributions start with "what creative thing shall
> > > >  we do now / what problem shall we tackle today in a creative
> > > >  way?" and work their way down to the technical level, which,
> > > >  as you rightly point out, requires successful _technical_
> > > >  contributions.
> > > 
> > > It's not my opinion, I'm stating historical fact. I honestly can't
> > > remember when a succesfull contribution was made based on a long
> > > non-technical thread. I can, however, remember oodles of cases where the
> > > reverse is quite true.
> >  
> >  ah.
> > 
> >  who's hosting the linux-visionaries mailing list, then?
> 
> :-)
> 
> Don't think there is one, but if it will take the traffic of this list,
> I'm sure davem can be quickly convinced to add one!
 
 davem, can we have a LVML, pleeeease?

 introductory text - capitalised of course:

 "the LVML - linux visionaries mailing list - is a place where linux
 kernel developers can gently but firmly push those people with
 'A Vision for Linux' so that they can get on with ...errmm...
 developing the linux kernel.  it's the place where 'i would love it if'
 can be frequently heard and revered, without fear of retribution
 or requests for an accompanying kernel patch."

 guidelines for posting on LVML:

 the list should be full of discussions beginning:
 
	 "wouldn't it be great if...", "has anyone considered ...",
	 "i have an idea".  "i am thinking of / considering ..."
 
 with intermediate stages comprising:

	 "that's a good idea because X but the problems are Y" or
	 "that is unrealistic because A, but a better or existing way
	  to do it is B"
 
 concluding in:
 
	 "okay, any takers for actually implementing this", "i've
	 implemented it", "i've started implementing it and really
	 now need to contact the LKML for a technical brain-picking
	 session: wish me luck".

 the list should _not_ be full of "that's a rubbish idea; don't even
 waste our time with it; prove it by implementing it and we won't speak
 or listen to you until you _have_ implemented it".
 

 you should really have a reasonable degree of expertise in at least one
 of the following areas (please advise LVML if you believe there should
 be any additions to this list.  the criteria for such items on this
 list is there to encourage people with a breadth or depth in
 specialist areas of expertise to get invovled.  for example, being a
 babbling idiot requires a _significant_ amount of talent):

	 * understanding of the history of kernel development:
	   unix, NT, netware, beos, mach, l4, gnu/hurd, you name it,
	   you've dissected it, met the developers, _are_ the developer,
	   or broken it so badly that people ran away screaming.

	 * high degree of exposure to a _significant_ number of
	   different programming languages.

	 * knowledge, expertise or exposure to a significant number
	   of futuristic, experimental, modern, ancient, obscure or
	   archaic hardware platforms, of any form: valves,
	   relays, transistors, gates, optical, magnetic -
	   you name it, you should have messed with it and
	   preferably received an overdose of some kind from it.

	 * the ability to absorb the contents of several high traffic
	   free software mailing lists: typically over 1,000 messages
	   per day.  people with adverse side-effects on brain function
	   of such a high degree of exposure to free software mailing
	   lists will be welcomed with open arms.

	 * the ability to converse happily with virtually any free
	   software developer, with or without beer, at conferences
	   and user groups, and to be able to make them think - even
	   if it's to think that you're a babbling idiot.

	 * talking complete and utter and very convincing nonsense.

	 * the ability to keep coming up with new ideas despite
	   clear and unequivocal contradictory statements from
	   virtually everyone around you that your ideas suck
	   goats.

 you should also have a high degree of tolerance for incoherent babbling
 idiots who at least show some some sparks of intelligence underneath.

 a full understanding of the linux kernel tree and its history
 is optional, except if you are a babbling idiot, under which
 circumstances you are expected to have a photographic recall
 of the entire linux source tree all the way back to its
 derivation.

 a liking for or tolerance of reactos, the gnu/hurd or any
 other experimental free software operating system is preferred.


 how about it?
 
-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--
