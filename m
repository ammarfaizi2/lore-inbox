Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263544AbUJ3FE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUJ3FE6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 01:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263550AbUJ3FE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 01:04:58 -0400
Received: from smtpout.mac.com ([17.250.248.97]:63729 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S263544AbUJ3FEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 01:04:54 -0400
In-Reply-To: <40231.65.208.227.246.1099077274.squirrel@www.lrsehosting.com>
References: <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org> <Pine.LNX.4.61.0410252350240.17266@scrub.home> <Pine.LNX.4.58.0410251732500.427@ppc970.osdl.org> <Pine.LNX.4.61.0410270223080.877@scrub.home> <Pine.LNX.4.58.0410261931540.28839@ppc970.osdl.org> <4180B9E9.3070801@andrew.cmu.edu> <20041028135348.GA18099@work.bitmover.com> <1098972379.3109.24.camel@gonzales> <20041028151004.GA3934@work.bitmover.com> <41827B89.4070809@hispalinux.es> <20041029173642.GA5318@work.bitmover.com> <41828707.3050803@hispalinux.es> <57875.65.208.227.246.1099074830.squirrel@www.lrsehosting.com> <4182923D.5040500@hispalinux.es> <40231.65.208.227.246.1099077274.squirrel@www.lrsehosting.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2540F67A-2A31-11D9-857E-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: James Bruce <bruce@andrew.cmu.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       =?ISO-8859-1?Q?Ram=F3n_Rey_Vicente?= <ramon.rey@hispalinux.es>,
       Xavier Bestel <xavier.bestel@free.fr>,
       Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Andrea Arcangeli <andrea@novell.com>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: BK kernel workflow
Date: Sat, 30 Oct 2004 01:04:15 -0400
To: Scott Lockwood <lkml@www.lrsehosting.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AFAIK, much of this has been rather confused talk about the status of 
"IP"
(Intellectual Property) in the US. I'm only familiar with US laws, so 
I'll
only talk to them, but this may apply for other countries too. IANAL, 
only
an informed student.  The only part of this discussion that I care about
is the "no contribute" clause in the BK license, that states that one 
may
not work on other SCM systems given certain relationships to BK users.

To start with, I'm going to ignore the DMCA for now, because it 
conflicts
hundreds of pages of preexisting laws and court cases, and is currently
hotly contended all over the place.

In the US there are three laws that protect the rights of authors of 
"stuff".
There is Trademark Law, which restricts usage of a brand name or image,
Patent Law, which restricts usage of a method or procedure, and
Copyright Law, which restricts distribution.  Trademark and Patent Law
do not apply to the license, because no-one here is attempting to 
deprive
Larry of his brand name(s) and he has (to my knowledge) filed no patent
on his BitKeeper algorithms.

Therefore the only remaining protection which he may enjoy is Copyright
protection, which restricts copying of some "product" without a license
from the author (Larry).  Copyright Law states that no-one may make and
distribute copies of BitKeeper without a license from Larry.  There may 
be
contractual obligations or monetary payment required to _obtain_ a copy
of said works, but once one has gotten said copy, they _own_ that copy.
They may *NOT* reproduce and/or distribute it without a license, but 
that
copy is theirs to do whatever they want with (Following any contract
agreed to _before_ obtaining the "product").

If someone else in the company I work for obtains BK, or if the company
itself obtains and uses BK, I am _not_ bound by their decisions, because
I am a separate entity, and I did not agree to said terms (Assuming that
this does not conflict with an employment contract).  Therefore you 
can't
assume association through business.

If I download the software and store it on my HDD, I _never_ have to
agree to the license before I download it, therefore I am under no 
license
concerning its use because any license is post-purchase, and therefore
not binding.

To my knowledge, there has not been a single significant instance of
a EULA made _after_ the point-of-sale being found binding by a court
of law.  There _have_ been many cases where Copyright law forbids
some action of a user also forbidden in an EULA, but in no other case
have they been upheld.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


