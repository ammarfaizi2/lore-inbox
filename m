Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129195AbQKFBHf>; Sun, 5 Nov 2000 20:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129745AbQKFBHZ>; Sun, 5 Nov 2000 20:07:25 -0500
Received: from riker.dsl.inconnect.com ([209.140.76.229]:32632 "EHLO
	ns1.rikers.org") by vger.kernel.org with ESMTP id <S129195AbQKFBHJ>;
	Sun, 5 Nov 2000 20:07:09 -0500
Message-ID: <3A0602E9.D59F2E50@Rikers.org>
Date: Sun, 05 Nov 2000 18:01:29 -0700
From: Tim Riker <Tim@Rikers.org>
Organization: Riker Family (http://rikers.org/)
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test9vaio i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russ Allbery <rra@stanford.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: non-gcc linux?
In-Reply-To: <fa.fvk85sv.1oigpiv@ifi.uio.no> <fa.cq7bdsv.gggbio@ifi.uio.no> <ylu29mey6f.fsf@windlord.stanford.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My understand of the argument for assigning all gcc copyright to the FSF
is that this make 'gcc' easier to defend. My example of an sgi-gcc shows
that sgi-gcc would have different criteria in a defense. This is solely
because both SGI and FSF would hold copyrights.

Now Marc Lehmann claims that this dual copyright code would be
"impossible" to defend. I merely pointed out that if that is truly the
case, gcc would also be indefensible because any GPL violator could
claim they took the source not from gcc, but from sgi-gcc which Marc
claims is indefensible.

I therefore assert that the fictitious sgi-gcc IS defensible and then by
conclusion that the current FSF position is not required to defend gcc
GPL. I am merely trying to assert what you stated as a given below:

> I think that the copyright assignment requirement is to some degree legal
> paranoia; sure, it's not *necessary* under copyright law, and in theory
> one could successfully defend the license without it.  But I can also very
> readily believe the advice of lawyers on the subject, namely that
> enforcement of the copyright is significantly easier in real court if one
> entity owns all of the rights.

In short the impact of adding code to gcc that is not copyright FSF is
minimal. Only the FSF copyrighted code would be defensible by the FSF.
Any other code GPL violations would be the responsibility of the
copyright owners to defend.

As before IANAL. ;-)

Russ Allbery wrote:
> 
> Tim Riker <Tim@Rikers.org> writes:
> 
> > I understand "will not", but "can not"? There is nothing stopping
> > anyone, let's say SGI for example, from branching a separate gcc which
> > would include copyrights assigned to FSF and other parties. Let's say
> > this happens and a new sgigcc source base is created. Presumably then
> > any defense of gcc code could be met with the argument that the code
> > used came from sgigcc. This being the case what has the FSD gained by
> > the current policy?
> 
> I'm unclear on how you're defining your terms, but were someone to have
> violated the GPL license on gcc, I don't understand how the existence of
> sgigcc would allow them to mount a defense.  The point of the copyright
> assignments is to make the copyright holder clear for legal purposes in
> the event of an attempt to violate the license.  You *seem* to be saying
> that somehow one could claim that gcc code wasn't actually owned by the
> FSF because it might have come from sgigcc (?), but of course that
> wouldn't be the case because all gcc code has copyright assignments.
> 
> > I suppose that this is even the case today as one could argue that code
> > came from intel-gcc if they used the Intel patches for ia64 or any other
> > non-FSF copyrighted patches including patches made by the same company
> > that the FSD might be in legal action with.
> 
> > In short, I do not see any enforceable advantages to the current FSF
> > policies.
> 
> I can see a whole bunch of advantages, and I'm afraid that your paragraphs
> above don't make any semantic sense to me.  Could you please clarify what
> you mean?
> 
> 
> --
> Russ Allbery (rra@stanford.edu)             <http://www.eyrie.org/~eagle/>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-- 
Tim Riker - http://rikers.org/ - short SIGs! <g>
All I need to know I could have learned in Kindergarten
... if I'd just been paying attention.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
