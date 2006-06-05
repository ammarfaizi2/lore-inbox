Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750728AbWFEUw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWFEUw6 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWFEUw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:52:58 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:12618 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750728AbWFEUw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:52:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VecZO20srVDrK6+c+LdVSOX2yP3t3wuafY9jkZFej5rzvrPidlsfIls7w361bWbaX/NUOAQXNdUA1edXP79eurG5E05oU++AJj7S3/6/8lIIFWJgGi4penyzjTik9yQKoJGWYoE6E4MjgTHs3cXaYcKZOFb2Bb9kpey2LOiKuiQ=
Message-ID: <4d8e3fd30606051352u51f1cd68y78eaef5b99e6b1ab@mail.gmail.com>
Date: Mon, 5 Jun 2006 22:52:56 +0200
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: Linux kernel development
Cc: "Horst von Brand" <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org,
        "Kalin KOZHUHAROV" <kalin@thinrope.net>,
        "Jesper Juhl" <jesper.juhl@gmail.com>, "Greg KH" <greg@kroah.com>
In-Reply-To: <1149519526.16247.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <paolo.ciarrocchi@gmail.com>
	 <4d8e3fd30606040330i6174f866vfe1c2cd30543a9c0@mail.gmail.com>
	 <200606042305.k54N5G2b010906@laptop11.inf.utfsm.cl>
	 <4d8e3fd30606050439j7e299655hf9967678e8739698@mail.gmail.com>
	 <1149519526.16247.3.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/06, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 2006-06-05 at 13:39 +0200, Paolo Ciarrocchi wrote:
>
> > > Could you add a README (including contact info, etc), and perhaps a TODO
> > > (and a copy of SubmittingPatches, which I assume applies here too?) to the
> > > project? A license for the text is required, AFAIU (GPLv2, or one of the
> > > Creative Commons licenses perhaps?).
> >
> > Not and exepert in this area, I think I'll release it under GPL2.
> >
> > What's the normal approach? Can I just add:
> > #             This document is distribuited under
> > #             GNU GENERAL PUBLIC LICENSE
> > #                    Version 2, June 1991
> > #               http://www.gnu.org/licenses/gpl.txt
> >
> > To the text?
> >
> > > [Yup, tangle it up in red tape even before it gets off the ground ;-]
> > >
>
> I released by writeup about the rt-mutex-design.txt (currently in -mm
> under Documentation) under the "GNU Free Documentation License, Version
> 1.2".
>
> If you want to read the license it is here:
>
> http://www.gnu.org/copyleft/fdl.html

Thanks Steven,
but a little part of the document is from inkernel documentation (and
vice versa, /Documentation/HOWTO includes part of this document) so I
stick with GPLv2.

I just pushed out the changes.

Ciao,
-- 
Paolo
http://paolociarrocchi.googlepages.com
