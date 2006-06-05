Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750993AbWFELjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWFELjj (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 07:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWFELjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 07:39:39 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:6329 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750985AbWFELjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 07:39:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rLWhhTT3mnHyQLKDXe/nv8MWLrqnYEDCLo3x6bUKKB+588fKu5b6O5Pc2JtNZ8GdG9pHElaJ1XnhqnyYfL8dwTJ+lU7SggyvVOeb4Q/oP1DzCOUWHN09Dfk4plIx4riZV4AilRxKP6mzF+1t7uD/gLQSvBOZCM48LfR/RTJpwDM=
Message-ID: <4d8e3fd30606050439j7e299655hf9967678e8739698@mail.gmail.com>
Date: Mon, 5 Jun 2006 13:39:28 +0200
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: "Horst von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Linux kernel development
Cc: linux-kernel@vger.kernel.org, "Kalin KOZHUHAROV" <kalin@thinrope.net>,
        "Jesper Juhl" <jesper.juhl@gmail.com>, "Greg KH" <greg@kroah.com>
In-Reply-To: <200606042305.k54N5G2b010906@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <paolo.ciarrocchi@gmail.com>
	 <4d8e3fd30606040330i6174f866vfe1c2cd30543a9c0@mail.gmail.com>
	 <200606042305.k54N5G2b010906@laptop11.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/06, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> > On 6/4/06, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> > > On 6/3/06, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> > [...]
> > >
> > > Thank you for your valuable comments!!
> >
> > BTW, I implemented a few changes according to your feedbacks.
> > Committed and pushed out.
>
> Thanks!
>
> Could you add a README (including contact info, etc), and perhaps a TODO
> (and a copy of SubmittingPatches, which I assume applies here too?) to the
> project? A license for the text is required, AFAIU (GPLv2, or one of the
> Creative Commons licenses perhaps?).

Not and exepert in this area, I think I'll release it under GPL2.

What's the normal approach? Can I just add:
#		This document is distribuited under
#		GNU GENERAL PUBLIC LICENSE
#		       Version 2, June 1991
#               http://www.gnu.org/licenses/gpl.txt

To the text?

> [Yup, tangle it up in red tape even before it gets off the ground ;-]
> --
> Dr. Horst H. von Brand                   User #22616 counter.li.org
> Departamento de Informatica                     Fono: +56 32 654431
> Universidad Tecnica Federico Santa Maria              +56 32 654239
> Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
>


-- 
Paolo
http://paolociarrocchi.googlepages.com
