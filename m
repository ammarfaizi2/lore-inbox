Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129195AbQKFAed>; Sun, 5 Nov 2000 19:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQKFAeY>; Sun, 5 Nov 2000 19:34:24 -0500
Received: from windlord.Stanford.EDU ([171.64.13.23]:47568 "HELO
	windlord.stanford.edu") by vger.kernel.org with SMTP
	id <S129260AbQKFAeI>; Sun, 5 Nov 2000 19:34:08 -0500
To: Tim@Rikers.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: non-gcc linux?
In-Reply-To: <fa.fvk85sv.1oigpiv@ifi.uio.no> <fa.cq7bdsv.gggbio@ifi.uio.no>
In-Reply-To: Tim Riker's message of "Sun, 5 Nov 2000 23:11:42 GMT"
From: Russ Allbery <rra@stanford.edu>
Organization: The Eyrie
Date: 05 Nov 2000 16:34:00 -0800
Message-ID: <ylu29mey6f.fsf@windlord.stanford.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Riker <Tim@Rikers.org> writes:

> I understand "will not", but "can not"? There is nothing stopping
> anyone, let's say SGI for example, from branching a separate gcc which
> would include copyrights assigned to FSF and other parties. Let's say
> this happens and a new sgigcc source base is created. Presumably then
> any defense of gcc code could be met with the argument that the code
> used came from sgigcc. This being the case what has the FSD gained by
> the current policy?

I'm unclear on how you're defining your terms, but were someone to have
violated the GPL license on gcc, I don't understand how the existence of
sgigcc would allow them to mount a defense.  The point of the copyright
assignments is to make the copyright holder clear for legal purposes in
the event of an attempt to violate the license.  You *seem* to be saying
that somehow one could claim that gcc code wasn't actually owned by the
FSF because it might have come from sgigcc (?), but of course that
wouldn't be the case because all gcc code has copyright assignments.

> I suppose that this is even the case today as one could argue that code
> came from intel-gcc if they used the Intel patches for ia64 or any other
> non-FSF copyrighted patches including patches made by the same company
> that the FSD might be in legal action with.

> In short, I do not see any enforceable advantages to the current FSF
> policies.

I can see a whole bunch of advantages, and I'm afraid that your paragraphs
above don't make any semantic sense to me.  Could you please clarify what
you mean?

I think that the copyright assignment requirement is to some degree legal
paranoia; sure, it's not *necessary* under copyright law, and in theory
one could successfully defend the license without it.  But I can also very
readily believe the advice of lawyers on the subject, namely that
enforcement of the copyright is significantly easier in real court if one
entity owns all of the rights.

-- 
Russ Allbery (rra@stanford.edu)             <http://www.eyrie.org/~eagle/>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
