Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750726AbWFEUvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWFEUvc (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWFEUvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:51:32 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:40008 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750726AbWFEUvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:51:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JNIlE1D42ua+JamAcGGFVTUrPFhTmKCgo/RI676UsAWasoT2d4dvfb9CUnN0lcleENqXWfEK0aeqM0qKj69o+DLe0U7kBidKnLnRL0bqI6N3UrG6w5xKvNQgyBdvwKE3h9sE34cAEARenyMoguu+5pQdV8jkKP83BOtIPpQ7IZs=
Message-ID: <4d8e3fd30606051351i5533b04vcbe9fe500201c3bb@mail.gmail.com>
Date: Mon, 5 Jun 2006 22:51:29 +0200
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: "Horst von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Linux kernel development
Cc: linux-kernel@vger.kernel.org, "Kalin KOZHUHAROV" <kalin@thinrope.net>,
        "Jesper Juhl" <jesper.juhl@gmail.com>, "Greg KH" <greg@kroah.com>
In-Reply-To: <200606051738.k55HcrC2025442@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <paolo.ciarrocchi@gmail.com>
	 <4d8e3fd30606050439j7e299655hf9967678e8739698@mail.gmail.com>
	 <200606051738.k55HcrC2025442@laptop11.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/06, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> > On 6/5/06, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
>
> [...]
>
> > > Could you add a README (including contact info, etc), and perhaps a TODO
> > > (and a copy of SubmittingPatches, which I assume applies here too?) to the
> > > project? A license for the text is required, AFAIU (GPLv2, or one of the
> > > Creative Commons licenses perhaps?).
> >
> > Not and exepert in this area, I think I'll release it under GPL2.
>
> Did you write all (most) of it? If not, you'd have to ask the original
> author(s).
>
> BTW, thinking it over in the shower today, if/when this is translated into
> asciidoc(1) (or whatever), a "source code" license (like GPLv2) would be
> appropiate IMHO. Besides, using the same license as what it describes is
> sensible.
>
> > What's the normal approach? Can I just add:
> > #             This document is distribuited under
> > #             GNU GENERAL PUBLIC LICENSE
> > #                    Version 2, June 1991
> > #               http://www.gnu.org/licenses/gpl.txt
> >
> > To the text?
>
> The license text spells it out ;-)
>
> I would add language to that effect to the README file, and bundle the
> standard COPYING file with the package

Modified and pushed out, since part of the document is from inkernel
documentation I choose GPL v2.

Thanks!

-- 
Paolo
http://paolociarrocchi.googlepages.com
