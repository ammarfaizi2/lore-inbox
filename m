Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbREZFAw>; Sat, 26 May 2001 01:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262607AbREZFAm>; Sat, 26 May 2001 01:00:42 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:6928 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S262604AbREZFA2>; Sat, 26 May 2001 01:00:28 -0400
Date: Fri, 25 May 2001 22:52:12 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: lm@bitmover.com, aaronl@vitelus.com, acahalan@cs.uml.edu,
        dledford@redhat.com, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
Message-ID: <20010525225212.A25429@vger.timpanogas.org>
In-Reply-To: <200105260234.TAA15586@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200105260234.TAA15586@baldur.yggdrasil.com>; from adam@yggdrasil.com on Fri, May 25, 2001 at 07:34:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 07:34:57PM -0700, Adam J. Richter wrote:


Copyright infringement would void the GPL, since it would involve
conversion (there's that fancy legal word for "steal" again) of someone 
else's property into another form if you take someone's code and copy it.  
Some things cannot be copyrighted, however, such as on-disk structures 
and wire protocol formats.  Conversion claims do not have to prove bad 
faith to succeed, unlike most other torts.   

Common formats for communications and networking typically can be carried 
from one code base into another without fear of infringement claims.   
Copying source or binary code line for line *IS* copyright infringement 
if the owner has filed and obtained a copyright.  Trade secrets are a bigger
concern.  I have never seen a copyright infringement case succeed with 
regard to someone writing new code, but in piracy cases, this is 
the central tort, along with trademark infringement.  

The Copyright office banned certain classes of computer technology, such
as on-disk and wire protocol formats from being copyrighted over 5 years
ago, so no worries here.

There is, however, a new legal doctrine called "intangible copyright 
infringement" which is being pushed by the same companies that 
brought us the "doctrine of inevitiable disclosure", the legal doctrine
that judges use to slap non-compete agreements on folks who have the 
misfortune of signing an NDA or trade secret agreement with an employer.

This doctrine states that copyrights can be infringed "intangibly" by 
copying common elements from another copyright and assembling them
in the same manner.  It has not been used in any case that does not 
also involve trade secret misapprpriation, and I doubt it will survive
it's first rounf od appeals, but several large software companies 
are engaging in experimental law with this doctrine in an attempt to 
halt open source erosion.

:-)

Jeff   




> Larry McVoy writes:
> >On Fri, May 25, 2001 at 10:02:08AM -0700, Adam J. Richter wrote:
> >> 	If you want to argue that a court will use a different definition
> >> of aggregation, then please explain why and quote that definition.  Also,
> >> it's important not to forget the word "mere."  If the combination is anything
> >> *more* than aggregration, then it's not _merely_ aggregation.  So,
> >> if you wanted to argue from the definition on webster.com:
> 
> >Adam, the point is not what the GPL says or what the definition is.
> >The point is "what is legal".  You can, for example, write a license
> >which says
> 
> >	By running the software covered by this license, you agree to 
> >	become my personal slave and you will be obligated to bring
> >	me coffee each morning for the rest of my life, greating
> >	me with a "Good morning, master, here is your coffee oh
> >	most magnificent one".
> 
> >If anyone is stupid enough to obey such a license, they need help.
> >The problem is that licenses can write whatever they want, but what they
> >say only has meaning if it is enforceable.  The "license" above would
> >be found to be unenforceable by the courts in about 30 seconds or so.
> 
> 	Contracts for slavery are specifically not enforceable due to
> the 13th Amendment, and there is also a stronger question of formation
> of a binding contract in your example, because the proposed mode of
> acceptance (related to the pointers I provided before) is doing
> something that you might have the right to do regardless of copyright
> (running the program as opposed to distributing copies).  I believe
> that people write contracts all the time that prohibit distribution of
> certain works with others, for marketing reasons.
> 
> >OK, so what does this have to do with aggregration?  The prevailing 
> >legal opinions seem to be that viral licenses cannot extend their
> >terms across boundaries.
> 
> 	We're not talking about mythically changing the copyright
> status of another work.  If your opinion is "prevailing" please
> include a reference to a section of the US code, a court decision
> or some reference that one could actually track down.
> 
> 	By the way, I have asked a lawyer at an IP litigation firm
> that we use about this and he indicated the copyright infringement case
> was quite strong.
> 
> Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
> adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
> +1 408 261-6630         | g g d r a s i l   United States of America
> fax +1 408 261-6631      "Free Software For The Rest Of Us."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
