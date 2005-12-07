Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbVLGXx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbVLGXx1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 18:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbVLGXx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 18:53:27 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:42765 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S964897AbVLGXx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 18:53:26 -0500
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6DAD0850-4943-416E-9E7B-095C6B412DD0@oxley.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jesse Barnes <jesse.barnes@intel.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Jon Masters <jonmasters@gmail.com>,
       Grahame White <grahame@regress.homelinux.org>,
       Benjamin LaHaise <bcrl@kvack.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Lars Marowsky-Bree <lmb@suse.de>,
       "linux-os ((Dick Johnson))" <linux-os@analogic.com>,
       Rik van Riel <riel@redhat.com>, Dirk Steuwer <dirk@steuwer.de>,
       Nicolas Mailhot <nicolas.mailhot@laposte.net>,
       Andrea Arcangeli <andrea@suse.de>, Lee Revell <rlrevell@joe-job.com>
Content-Transfer-Encoding: 7bit
From: Felix Oxley <lkml@oxley.org>
Subject: Linux Hardware Quality Labs (was: Linux in a binary world... a doomsday scenario)
Date: Wed, 7 Dec 2005 23:53:19 +0000
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The topic of binary modules has been raised many times recently (I'm  
quite new here :-) in respect of the ndiswrapper and 4k stacks,  
discussion of 3D graphics drivers and most recently Arjan's "Doomsday  
Scenario" thread. Whilst reading the Doomsday thread it became  
apparent to me, and to several other people (please see my apology at  
the end of this mail), that what is required is a Logo program  
similar to the "Designed for Windows XP" logo.

The primary motivation for this is that it leverages the individual  
power of each purchaser (of a system or individual piece of hardware)  
be they a consumer, SME, system builder, tier 1 or 2 PC manufacturer,  
government dept., or Linux distro company, into a single point of  
pressure that can be applied to OEMs to ensure that they provide open  
source drivers.

Unlike previous lists of equipment that works with Linux, this would  
of course have to be centrally administered.
Simply, hardware manufacturers would be able to use the LHQL logo  
(whatever it looks like or is called) once their kit had been  
certified, the primary requirement for which would be either that a   
fully featured open source driver was available or that all the  
relevant documentation had been put in to the public domain so that  
anybody could write one.


Why will this work? Here is how I see it developing in the server  
market:

1. The logo will be launched along with a campaign to explain to  
technical users that (a) open source drivers are better quality, (b)  
that binary drivers threaten the future of the Linux ecosystem.

2. Any company which manufactures equipment with open source drivers  
already available will have the logo granted for their current  
equipment.
      This means that right from the outset it will be possible to  
put together a system which is wholly conformant, i.e. the entire PC  
is eligible to carry the logo.
3. Certain small system builders will get on board.
4. Obviously, everyone on LKML will only buy/recommend hardware which  
carries "the mark of the penguin". As will geeks the world over.
5. One of the distros will decide that their "Supported Hardware"  
list will only feature items with the logo.
6. Medium sized system builders, maybe "partners" of the distro will  
begin to ship systems that fully conform.
7. All the supporters above will be using the the new Open Source  
Graphics hardware from www.opengraphics.org. (Important later)
8. Corporate or government buyers will by now become aware of the  
value of buying certified equipment.

Up until this point the OEMs that we wish to influence have not taken  
much notice.
However, once stage 8 is reached, having the logo will be easily  
understood to be a competitive advantage.
The inflection point has then been reached. Each of the producer  
groups i.e. OEMs, PC vendors and distros then increasing use the logo.

Who Pays?
1. _Not_ the OEM. Producing the open source driver is their  
contribution.
2. PC vendors who build system from multiple conformant parts who  
then wish to badge the entire system can pay an amount.
3. OSDL or a similar body would (or a wealthy benefactor) would be  
required to provide initial funding.

Who Certifies?
1. This was discussed in the other threads, the feeling seemed to be  
that it should be kept close to the LKML/maintainers and should not  
be controlled by a body which could be subjected to  financial pressure.

What is required for Certification? (I am not qualified to answer  
this question)
1. The driver must be GPLed and fully support the features of the  
hardware (or match the support given to Windows Server/Client)
2. Any other software quality / security tests that you think is  
appropriate.

Desktop
======
So far I have been talking only of the server.

My assumptions when discussing the Desktop segment are as follows:

(1) Early comments in the "Doomsday Scenario" thread were indicating  
that the state of drivers for consumer level machines was fairly  
poor. But also that despite much hype the Linux Desktop really isn't  
here yet. The 2 things are obviously somewhat connected, as discussed  
at the recent OSDL desktop summit.
(2) Also, the major point of pain on the desktop seems to concern the  
graphics chipsets.
(3) Cutting edge graphics cards in PCs are mainly required for  
gamers. I read today that the PC games market is going to be dead in  
5 years :-).

Since the market for consumer machines has not yet reached a level at  
which OEMs feel they need to seriously address it, this obviously  
provides some time for the Logo program to become established and  
successful in the server market. During this period the level of  
graphics support available from OEMs other than ATI & NVidia will  
improve.

For example:
   i) the OpenGraphics project will hopefully have flourished,  
partially due to the Logo program.
   ii) A number of smaller graphics OEMs will supply Open Source kit.
   iii) Intel will provide fully conformant on-board graphics  
solutions. 	

Therefore a consumer wishing to purchase a modern system with a  
reasonably powerful graphics engine (i.e. more powerful than anything  
available today) will have several options, even if the tier 1  
graphics vendors are not yet providing Open Source drivers.

This will of course place them at a competitive disadvantage that  
they will wish to avoid. So they apply for the logo. :-)

Thanks for listening.
regards,
Felix

Apologies
1. Apologies to anybody who thought of this months/years ago.
2. Apologies to everyone in the "Doomsday Scenario" thread who  
suggested this. I am not crediting you by name simply because I do  
not want to re-read all 100 entries to find your names.
3. Apologies to Benjamin LaHaise who has already started a thread  
called "Runs with Linux (TM)" based on his prior independent   
conclusion that this is the correct course of action.
4. Apologies to everyone I have CC'ed based on the particular input  
they made on the "Doomsday Scenario" thread.
5. To anybody I upset, I am only posting this because I really do  
think that it is The Answer (tm) and I want many people to consider it.
