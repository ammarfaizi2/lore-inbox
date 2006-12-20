Return-Path: <linux-kernel-owner+w=401wt.eu-S1161014AbWLTXId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbWLTXId (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbWLTXId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:08:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:57457 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161008AbWLTXIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:08:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XBsu/qF1v2fYgcTBbssaTkn9853qgxTJh24EcICSWzH+uDZXPuhsDYbrqiYvKT/j+23sjPWlp0fmUV2mn7AKKKHDuAPPuv89zp3E0T6mYGOI6vkN4LjwB7WJLtMhSyFRSsFfimY9XTPnX1g1bLSUgqXiRq46wg5dLCNjTfDtnWg=
Message-ID: <7b69d1470612201508y609cd65fr8bfb007f667f4215@mail.gmail.com>
Date: Wed, 20 Dec 2006 17:08:29 -0600
From: "Scott Preece" <sepreece@gmail.com>
To: davids@webmaster.com
Subject: Re: GPL only modules
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMEKNAHAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612181839460.20138@iabervon.org>
	 <MDEHLPKNGKAHNMBLJOLKMEKNAHAC.davids@webmaster.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/06, David Schwartz <davids@webmaster.com> wrote:

> > I'd agree that "ar", like "mkisofs", doesn't create a derived work, but I
> > think that "objcopy" does create a derived work, and "ld" does too, by
> > virtue of modifying the objects it takes to resolve symbols. ...
>
> The question is, as a matter of copyright law, what right do you need to
> distribute the aggregate? As I understand the law, the answer is that you
> need the right to distribute each of the individual works in the aggregate.
> Fortunately, you can trivially get the right to distribute any GPL'd work
> under first sale. (Simply download as many copies as you plan to
> distribute.)
>
> To argue otherwise would be to argue that you can't buy a DVD and a Hallmark
> card and ship the two of them together to your mother.
---

If the aggregate is not a derived work, then you only need the
separate permissions for the original works. If the aggregate is a
derived work, then you need permissions relative to the derived work,
not just the original work - essenitlally, permission to modify the
work. And, the permissions would all have to allow the specific form
of distribution and aggregation involved. [Don't give me back the
example of breaking the DVD in half - "the work" is not the medium;
your purchase of a DVD does not give you the right to modify the movie
it carries and redistribute the modified version, even under first
sale.]

---
>
> >This is an interesting argument that was new to me. However, it is not
> >clear at all that First Sale applies to intangible copies. And it's
> >not clear that there is a sale involved, legally. Again, IANAL, but I
> >think this is seriously untested ground.
>
> First sale has nothing do with a sale. 17 USC 109(a) says, "Notwithstanding
> the provisions of section 106 (3), the owner of a particular copy or
> phonorecord lawfully made under this title, or any person authorized by such
> owner, is entitled, without the authority of the copyright owner, to sell or
> otherwise dispose of the possession of that copy or phonorecord."
---

While I generally agree with you that first sale can occur without an
actual sale, the GPL (and distribution by free download in general) is
an odd situation (the law wasn't designed for works that could be
freely copied) and I would not suggest anyone depend on a court to
interpret that clause the way you are.

---
> I'm not really qualified to respond to the argument that first sale doesn't
> apply to an intangible copy. As the law is written, it simply refers to the
> owner of a "a particular copy". Sometimes "a copy" only means tangible
> copies and sometimes it simply means the result of copying. It seems bizarre
> to me, however, to argue that if I lawfully download a program, I need
> special permission from the copyright holder to put it on CD but not a hard
> drive. What is the *legal* difference? And if I put it no a hard drive, I
> can't sell it? Seems crazy to me.
---

Nevertheless, the only decided cases I could find in the area went the
other way - saying that intangible copies did not exhaust the author's
distribution rights. Note that your example is misleading - you don't
need different permission to put it on a CD than to put it on a hard
drive, but you might not have permission to distribute it (depending
on the terms under which you received it). There is case law finding
that, in at least some cases, the author's rights in particular copies
(even tangible copies) was not exhausted.

---
>
> Nobody ever said a copyright holder couldn't restrict the distribution of
> his software when such distribution is not authorized by things like fair
> use, first sale, or other things. Of course a copyright holder can set any
> rules he want for those distributions not authorized by law.
>
> However, those restrictions do not affect those who did not agree to them.
> For example, if I buy such a JVM and don't agree to the license (assuming I
> don't have to agree to the license to lawfully acquire the JVM), I can give
> it to a friend along with any other software I want.
---

No, as with the language in the GPL, your right to distribute is
provided by the license you received with the JVM, so if you don't
accept it, you can't distribute. However, the first sale doctrine
provides a limited exception; if you got the JVM through an
unrestricted sale, then you would normally have the right to sell that
particular copy without any further license (though possibly not to
someone in a different part of the world).

scott
