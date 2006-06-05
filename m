Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751133AbWFEO7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWFEO7J (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 10:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWFEO7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 10:59:09 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:43650 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751133AbWFEO7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 10:59:08 -0400
Subject: Re: Linux kernel development
From: Steven Rostedt <rostedt@goodmis.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org,
        Kalin KOZHUHAROV <kalin@thinrope.net>,
        Jesper Juhl <jesper.juhl@gmail.com>, Greg KH <greg@kroah.com>
In-Reply-To: <4d8e3fd30606050439j7e299655hf9967678e8739698@mail.gmail.com>
References: <paolo.ciarrocchi@gmail.com>
	 <4d8e3fd30606040330i6174f866vfe1c2cd30543a9c0@mail.gmail.com>
	 <200606042305.k54N5G2b010906@laptop11.inf.utfsm.cl>
	 <4d8e3fd30606050439j7e299655hf9967678e8739698@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 05 Jun 2006 10:58:46 -0400
Message-Id: <1149519526.16247.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-05 at 13:39 +0200, Paolo Ciarrocchi wrote:

> > Could you add a README (including contact info, etc), and perhaps a TODO
> > (and a copy of SubmittingPatches, which I assume applies here too?) to the
> > project? A license for the text is required, AFAIU (GPLv2, or one of the
> > Creative Commons licenses perhaps?).
> 
> Not and exepert in this area, I think I'll release it under GPL2.
> 
> What's the normal approach? Can I just add:
> #		This document is distribuited under
> #		GNU GENERAL PUBLIC LICENSE
> #		       Version 2, June 1991
> #               http://www.gnu.org/licenses/gpl.txt
> 
> To the text?
> 
> > [Yup, tangle it up in red tape even before it gets off the ground ;-]
> >

I released by writeup about the rt-mutex-design.txt (currently in -mm
under Documentation) under the "GNU Free Documentation License, Version
1.2".

If you want to read the license it is here:

http://www.gnu.org/copyleft/fdl.html

-- Steve


