Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129590AbQLCENb>; Sat, 2 Dec 2000 23:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129667AbQLCENV>; Sat, 2 Dec 2000 23:13:21 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:46994 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S129590AbQLCENC>;
	Sat, 2 Dec 2000 23:13:02 -0500
Date: Sat, 2 Dec 2000 22:42:29 -0500
Message-Id: <200012030342.WAA17517@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: "Theodore Y. Ts'o" <tytso@MIT.EDU>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        pavel@suse.cz, kernel@blackhole.compendium-tech.com, hps@tanstaafl.de,
        linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
In-Reply-To: Jeff V. Merkey's message of Sat, 2 Dec 2000 18:21:26 -0700,
	<20001202182126.A20944@vger.timpanogas.org>
Subject: Re: Fasttrak100 questions...
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Sat, 2 Dec 2000 18:21:26 -0700
   From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>

   Under this argument, it is argued that the engineer who had source 
   code access "inevitably used" negative knowledge he gained from 
   his study of the Linux sources.  Absent the vague descriptions of
   what a "derivative work" is in the GPL, it could be argued that 
   conversion of any knowledge contained in GPL code is a "derivative
   work".  

That's bullshit.  Copyright law very clearly states that it protects the
fixation of an idea in a medium, and that copyright explicitly does not
protect the idea itself.  The concept of what is a derived work is very
clearly understood, and there have been a lot of court cases to define
this precedent.  (My understanding is that in realm of music 7 notes in
sequence, if copied, is prima facie evidence that there is a derived
work.  Not 5 notes, and not 8 notes, but seven notes.  Gotta love those
lawyers at work.  Aren't you glad they settled that?)

   Personally, I think the doctrine is one of the most evil fucking things
   in existence, legal opponents call it "the doctrine of intellectual
   slavery" because it has the affect under the law to be able to convert
   simple NDA agreements into non-compete agreements, and I've seen it 
   used this way.

That's a different matter.  If you use NDA and Trade secret law, then
yes, might be able to enslave programmers using such a law.  However
most courts have strict limits to how far they will take non-compete
arguments, and if an NDA turned into a non-compete, past a certain point
they will say that a person has a right to earn a living.....
Fortunately most judges will apply some amount of common sense, even
despite their law school training.  In any case, the GPL doesn't involve
NDA's or Trade Secrets, so saying that this doctrine could be used to
contaminate non-GPL code simply by having people look at GPL code is
bullshit.

No question, though, the first thing we should do, is kill all the
lawyers.  (And this is now definitely off-topic for the linux-kernel
list.)

						- Ted

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
