Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129844AbQKBWYq>; Thu, 2 Nov 2000 17:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129839AbQKBWYg>; Thu, 2 Nov 2000 17:24:36 -0500
Received: from front1.grolier.fr ([194.158.96.51]:48310 "EHLO
	front1.grolier.fr") by vger.kernel.org with ESMTP
	id <S129819AbQKBWYU> convert rfc822-to-8bit; Thu, 2 Nov 2000 17:24:20 -0500
Date: Thu, 2 Nov 2000 22:24:27 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: "David S. Miller" <davem@redhat.com>
cc: cort@fsmlabs.com, npsimons@fsmlabs.com, garloff@suse.de,
        jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
In-Reply-To: <200011012345.PAA20284@pizda.ninka.net>
Message-ID: <Pine.LNX.4.10.10011022209420.2328-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Nov 2000, David S. Miller wrote:

>    Date: Wed, 1 Nov 2000 16:54:18 -0700
>    From: Cort Dougan <cort@fsmlabs.com>
> 
>    Since you're setting yourself up as a proponent of this can you
>    explain why RedHat includes a compiler that doesn't work with the
>    kernel?
> 
> Because the kernel is buggy (the specifics of this has been discussed

Every software seems to be buggy and gcc does not seem to be better than 
the kernel in this area.

> before on this list) and we didn't have time to implement and QA the
> changes needed in time for the 7.0 release.
> 
> Furthermore I was correcting Nathan's statement that this was a "Red
> Hat thing", not specifically upholding the virtues of using a
> different compiler for the kernel.  That is a completely seperate
> topic and we've had that taken that conversation as far as it will go
> already remember? :-)

You were just claiming that other main Linux packagers do also suggest a
different compiler version for the kernel, which was only part of the
facts that let RedHat 7 have been loose with its kgcc/gcc mess.

And since it seems that everybody can build a Linux based package in his 
garage and then find morons to buy it, let me ask my mother-in-law if 
she also did so and let the planet know how she decide to handle the
kernel compiler issue, if this can let you feel better. :o)

> Finally, if I were to state "fsmlabs are a bunch of pinheads because
> they did XXX" I would expect you to defend your employer as well if I
> misrepresented them due to incorrect statements.  Right?  :-)

Wrong, as far as it is David S. Miller who is one of the greatest Linux 
contributors that made Linux become what it is nowadays, mostly as a free
contributors for years.

I would even accept something like "you caring about your stock-options
not to be victimized by RH7 kgcc blundering", but certainly not that you
just want to blindly defend your employer for corporate reasons.

Regards,
  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
