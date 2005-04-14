Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVDNMS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVDNMS4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 08:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVDNMS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 08:18:56 -0400
Received: from hades.almg.gov.br ([200.198.60.36]:33772 "EHLO
	hades.almg.gov.br") by vger.kernel.org with ESMTP id S261483AbVDNMSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 08:18:36 -0400
Message-ID: <425E5FA6.1030702@almg.gov.br>
Date: Thu, 14 Apr 2005 09:18:46 -0300
From: Humberto Massa <humberto.massa@almg.gov.br>
User-Agent: Mozilla Thunderbird 1.0+ (Windows/20050224)
MIME-Version: 1.0
To: debian-legal@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
 copyright notice.
References: <JMgucB.A.0PB.b3cXCB@murphy>
In-Reply-To: <JMgucB.A.0PB.b3cXCB@murphy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:

 >> >Would you agree that compiling and linking a program that
 >> >uses a library creates a derivative work of that library?
 >
 >
 >>No. Compiling and linking are mechanical,
 >>non-intellectually-novel acts. At most, you have a
 >>collective work where the real intellectually-novel work was
 >>to select what goes into the collective.
 >
 >
 >    Compiling and linking are mechanical, but unless you
 >want to argue that the result is not a single work, it
 >clearly creates a derivative work of all the things linked.
 >The creativity is not in the linking itself but in the
 >creation of the individual works such that they can be linked
 >together.

That is the point: the result is not a single work. It is a
collection or compilation of works, just like an anthology. If
there is any creativity involved, is in choosing and ordering
the parts. The creation of works that "can be linked together"
is not protected by copyright: the literary analogy was to
"create a robot short story". Such a story could go into an
anthology called (duh) "Robot Short Stories", but its
licensing is independent of every other robot short story in
the world -- except those it is a derivative work of.

Now, this is what copyright protects: creation of derivative
works (see the definition, below) is an exclusive right of the
copyright owner. I can't write a history featuring Daneel
Olivaw or Susan Calving without the (written, express)
permission of Mrs. Asimov and/or her daughter. And if I *do*
have their consent (in the form of GPL'ing it, for instance),
even so I can only copy and distribute *my* work in the terms
permitted expressely by the consent I received (in the
example, the terms of the GPL)

 >
 >> >Wouldn't you agree that this is the normal form of use of
 >> >a library?  And doesn't first sale give you the right to
 >> >normal use of a work you have legally acquired?
 >>
 >>Yes. And yes, if you buy a copy of the library, yes (but
 >>notice: not if you downloaded it for free from the Net).
 >
 >
 >    There is no legal distinction.

Why do you think that? You can even be right on this, but your
argument below did not convince me.

 >Your rights come not from the fact that you paid money for
 >the work but simply from the fact that you acquired it
 >legally. Again, the reductio ad absurdum is the guy who drops
 >copies of his poem from an airplane and then demands
 >royalities from everyone who reads it. If you legally
 >acquired it, you get the bundle of rights under first sale.

You are spinning, you know? If I drop a poem from an airplane,
and you get it from the ground, you can read it (this is not
forbidden by copyright law) but you have *no* right of copying
it, publishing it or redistributing it. Especially if my poem
has my name or pseudonym on it.

Yeah, you can even get the bundle of rights under first sale
if you acquired it lawfully, and I must be wrong about my
quoted paragraph above, and so I back out on my error and
apologize for it.

But making a derivative work is not (in principle) a first
sale doctrine right.

 >
 >> >There are many ways you can lawfully create a derivative
 >> >work without explicit permission of the copyright holder.
 >> >One
 >>
 >>No. The copyright law states that the copyright owner has
 >>the monopolistic right to create derivative works.
 >
 >
 >    Yes, but this doesn't restrict first sale or fair use.
 >You cannot use a library without creating a derivative work,
 >so if first sale grants you rights to use, it automatically
 >grants you the right to do anything necessary for use.

You are making deaf ears: using a library (even by static
linkage) does NOT create a derivative work unless:

        (a) you make another version, subset or superset of
        the same library, modifying, enhancing, the
        functionality of the original library; or

        (b) you make a program that is *so* dependent on the
        *internal* implementation structure of the library
        that it can be considered a derivative work.

 >
 >> >clear case is when you lawfully possess the work, there is
 >> >no EULA or shrink-wrap agreement, and you need to produce
 >> >a derivative work to use the work in the ordinary fashion.
 >
 >
 >>No... Try writing a book with Harry Potter as your main
 >>character and JKR's lawyers will be at your door soon.
 >
 >
 >Sometimes I wonder if you are reading what I said or not.

Me too.

 >I said "you need to produce a derivative work to use the
 >work in the ordinary fashion" and you say "No" and follow
 >with an example where you clearly *don't* need to produce a
 >derivative work to use the work in the ordinary fashion.

Ok, let's replay: David: "There are many ways you can lawfully
create a derivative work." Me: "no, the only way to create a
derivative work lawfully is having an authorization from the
copyright owner." David: "You cannot use a library without
creating a derivative work,", implying that it would be your
first sale doctring right. Me: "No, simply linking a library
in NO hypothesis creates a derivative work."

Summary? You could not show me any example where you *must*
create a derivative work to exert your first sale rights.

 >
 >> >This is, by the way, the FSF's own position. It's not
 >> >something I'm making up or guessing at.
 >>
 >>Please send us some pointers to this statements for the FSF.
 >
 >
 >    Read any of Eben Moglen's posts.
 >
 >> >"The license does not require anyone to accept it in order
 >> >to acquire, install, use, inspect, or even experimentally
 >> >modify GPL'd software. All of those activities are either
 >> >forbidden
 >>
 >>Wrong again. GPL, section 0, para 1: "Activities other than
 >>copying, distribution, and *modification* are not covered by
 >>this License". Emphasis mine.
 >
 >
 >You are free to disagree with the FSF's interpretation of the
 >GPL, but you are not free to misrepresent the FSF's
 >interpreration.

No. First of all: you are begin uncivil here. I did not accuse
you of anything, other than not reading correctly what I
wrote previously; which I can attribute to my poor knowledge
of the English language. So, please, I am not being impolite
to you, do the same.

Second: you did not provide a concrete pointer to one of Eben
Moglen's posts, for instance, saying that modification is not
covered by the GPL. Me, OTOH, showed you that the TEXT of the
GPL says it covers modifications.

 >
 >> >or controlled by proprietary software firms, so they
 >> >require you to accept a license, including contractual
 >> >provisions outside the reach of copyright, before you can
 >> >use their works.  The free software movement thinks all
 >> >those activities are rights, which all users ought to
 >> >have; we don't even want to cover those activities by
 >> >license."
 >>
 >>Except for the modification part, which *is* the scope of
 >>regular, Berne-convention-molded copyrights law.
 >
 >
 >Feel free to disagree with the FSF about the meaning of the
 >GPL, but it is the FSF's position that you can modify a GPL'd
 >work without agreeing to the GPL.

I don't disagree with the FSF -- you are alleging that this is
their position, and I am disagreeing with YOU. And you have
not produced evidence in contrary.

 >
 >> >Now we draw different conclusions based on this, but we
 >> >agree on this. You do not need to agree to the GPL to
 >> >create derivative works.
 >>
 >>No, we disagree on this too.
 >
 >
 >    I don't know who "we" is, but I agree with the FSF.

We = You and Me disagreeing. And you still have to show where
the FSF says the GPL does not cover modifications.

 >
 >> >>If you will keep your copy and registration # of windows,
 >> >>yes, you *must* wipe out the machine before selling it.
 >> >
 >> >
 >> >Since there is no copy or registration number of a GPL'd
 >> >work to keep, this actually argues the reverse of what I
 >> >said. If I legally acquire ten copies of Windows, I can
 >> >perform normal use on those ten copies and then transfer
 >> >those copies to someone else.
 >
 >
 >>This is not the point: you still would have to wipe your ten
 >>computers clean if you want to sell the ten copies you have.
 >
 >
 >    Right. You cannot increase the number of copies.
 >
 >>In the GPL'd case, if you disregard the terms of the
 >>license, you can still keep, use, etc. You can *not* copy
 >>it, distribute it, or modify it tough.
 >
 >
 >You can, so long as you don't increase the number of copies.
 >This is a right under first sale.

Ok, I'll concede on this.

 >
 >> >>So, no, when you get a WinXP CD from Microsoft, you have
 >> >>absolutely *no* rights to create derivative works. If a
 >> >>person creates a derivative work, even if it does not
 >> >>distribute it, it would be infringing on MS's copyrights
 >> >>and I would not want to be in said person's shoes, if
 >> >>someone in the legal department of MS wakes up in the
 >> >>wrong side of the bed.
 >
 >
 >> >But you do have the right to create derivative works if
 >> >such derivative works are necessarily created in the
 >> >process of the ordinary use of the work.
 >
 >
 >>Ok, let's repeat ourselves:
 >
 >
 >>A derivative work is a novel intellectual creation (of the
 >>spirit) that results from some transformation of another
 >>work, said the "original" work.
 >>
 >>There is a similar (identical?) definition on 17 USC, but I
 >>am quoting (bad translation mine) our "Lei 9610/98 -- Lei de
 >>Direitos Autorais" (1998 Brazilian Author's Rights Act),
 >>art.  5º, VIII, 'g'.
 >>
 >>I can't think of any example where to use a work, you must
 >>create another work transforming the first. If you can,
 >>please enlighten me. Beware: your *spirit* must transform
 >>the work, not your computer. Yes, as when *you* translate a
 >>book to another language, in an
 >>non-automatable-non-automated process.
 >
 >
 >To use a library, you must write a program that uses that
 >libraries and includes its header files. You must compile the
 >library and the program, and link the result. You must then
 >execute the result.
 >
 >    You can argue it one of two ways:
 >
 >    1) The result is a derivative work, hence creating a
 >derivative work is necessary for ordinary use. Thus
 >permission to use means permission to create (at least some)
 >derivative works.

        ** NOT THIS ** :-)
 >
 >    2) The result is not a derivative work, hence you
 >don't need permission from the copyright holder to do it.

        ** THIS ** : yes, the result is NOT a derivative work.
        So, to link with a library you don't need permission.
        That's what I said since the beginning.

 >    Either way you get the same result, permission is not
 >needed beyond permission to use.

Conceded.

 >
 >> >I think that if I write software that runs under Windows,
 >> >an argument can be made that that software is a derivative
 >> >work of Windows. That
 >
 >
 >>No, no, no, and no. A derivative work is not something that
 >>is "argumentable" :-). There is a clear legal definition,
 >>and there are even tools (the Holy Trinity of Derivation:
 >>Abstraction, Filtration, Comparison) to help us define and
 >>discover what is and what is not a derivative work. And no,
 >>HelloWorld.c is not a derivative work of Windows, even if it
 >>#include<windows.h>
 >>
 >>please, google for:
 >>
 >>abstraction filtration comparison derivative
 >>
 >>-- it will be enlightening.
 >
 >
 >    Then all the people who think that creating a binary
 >kernel module requires creating a derivative work and hence
 >can be restricted by the GPL are wrong.  Take that argument
 >up with them.

I took. Google my name on lkml and you'll see. They ARE wrong.
Linus himself studied carefully the situation and came to the
conclusion they are wrong,

I'll rewrite something, from this e-mail, for emphasis:

"You are making deaf ears: using a library (even by static
linkage) does NOT create a derivative work unless:

        (a) you make another version, subset or superset of
        the same library, modifying, enhancing, the
        functionality of the original library; or

        (b) you make a program that is *so* dependent on the
        *internal* implementation structure of the library
        that it can be considered a derivative work."

If you make a kernel module that only uses something
EXPORT_SYMBOL()'d from the kernel, you are NOT in principle
writing a derivative work. If you use EXPORT_SYMBOL_GPL()'d
symbols, then you are incurring in (b) above and your kernel
module is most certainly a derivative work.

I think Linus' opinion pacified this point, at least on LKML.


 >
 >> >argument is as strong as the argument that a driver with
 >> >linked in firmware is a single work.
 >>
 >>This would most certainly not prevail in any court at all.
 >>Obviously, IANAL and TINLA applies. But, that said, I have
 >>good credentials :-)
 >
 >    I think even if the result is not a derivative work,
 >the rules for distributing it would be the same. However, it
 >would change the rules for creating it. Either way, however,
 >you get that you can do it without agreeing to the GPL, and
 >this is the FSF's position.

You repeated this a lot of times, but you have not
substatitiated it, at least WRT something I asked you: please,
give me some *link* where EM, RMS, or any other FSF/GNU guy
contradicts the GPL section 0 paragraph 1 ("modification")
saying that you can modify a GPLd work without agreeing to the
GPL.
 >
 >    DS

Hey, I am trying to help, don't be so hostile :-)

Massa

PS: yes, the "broken threads" thing p*sses me off too, but I
can't prevent it.

