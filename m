Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751240AbWFERjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWFERjr (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 13:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWFERjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 13:39:47 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:13013 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751240AbWFERjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 13:39:47 -0400
Message-Id: <200606051738.k55HcrC2025442@laptop11.inf.utfsm.cl>
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
cc: linux-kernel@vger.kernel.org, "Kalin KOZHUHAROV" <kalin@thinrope.net>,
        "Jesper Juhl" <jesper.juhl@gmail.com>, "Greg KH" <greg@kroah.com>
Subject: Re: Linux kernel development 
In-Reply-To: Message from "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> 
   of "Mon, 05 Jun 2006 13:39:28 +0200." <4d8e3fd30606050439j7e299655hf9967678e8739698@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Mon, 05 Jun 2006 13:38:53 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 05 Jun 2006 13:38:58 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> On 6/5/06, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:

[...]

> > Could you add a README (including contact info, etc), and perhaps a TODO
> > (and a copy of SubmittingPatches, which I assume applies here too?) to the
> > project? A license for the text is required, AFAIU (GPLv2, or one of the
> > Creative Commons licenses perhaps?).
> 
> Not and exepert in this area, I think I'll release it under GPL2.

Did you write all (most) of it? If not, you'd have to ask the original
author(s).

BTW, thinking it over in the shower today, if/when this is translated into
asciidoc(1) (or whatever), a "source code" license (like GPLv2) would be
appropiate IMHO. Besides, using the same license as what it describes is
sensible.

> What's the normal approach? Can I just add:
> #		This document is distribuited under
> #		GNU GENERAL PUBLIC LICENSE
> #		       Version 2, June 1991
> #               http://www.gnu.org/licenses/gpl.txt
> 
> To the text?

The license text spells it out ;-)

I would add language to that effect to the README file, and bundle the
standard COPYING file with the package
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
