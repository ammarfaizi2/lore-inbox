Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbULROZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbULROZB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 09:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbULROZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 09:25:00 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:23273 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261169AbULROWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 09:22:06 -0500
Message-Id: <200412180152.iBI1q98X007507@laptop11.inf.utfsm.cl>
To: Hans Reiser <reiser@namesys.com>
cc: David Masover <ninja@slaphack.com>,
       Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>,
       reiserfs-list@namesys.com, linux-kernel@vger.kernel.org,
       Nate Diller <ndiller@namesys.com>
Subject: Re: file as a directory 
In-Reply-To: Message from Hans Reiser <reiser@namesys.com> 
   of "Fri, 17 Dec 2004 08:52:44 -0800." <41C30EDC.5030502@namesys.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Fri, 17 Dec 2004 22:52:09 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> said:
> David Masover wrote:
> > Hans Reiser wrote:
> > [...]
> > | My solution is to tell Nate Diller that there is extensive literature on
> > | it, that it isn't really the big problem it is made out to be, and leave
> > | it to him to go read the literature and code it up after he finishes the
> > | required tasks of our current darpa contract.;-)

> > Can you point me to any such literature?  I'm just curious.

> Look in every field of cs except filesystems and kernels.;-)

Right. Smart people are found elsewhere only.

>                                                              Databases, 
> garbage collectors, etc.

Everthing stuff that works on the assumption that what they are working on
fits in RAM (or can overflow into swap space in a pinch), and that RAM is
fast (and even so they are infuriatingly slow). And disks are usually a few
thousand times larger than RAM (more stuff to shuffle around) and a million
times slower...

>                          Specific reference, no, I didn't collect them, 
> sorry, but alexander the befs driver guy knows more than I about this.

Furious handwaving doesn't make it true.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
