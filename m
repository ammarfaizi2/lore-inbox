Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277399AbRJEOhD>; Fri, 5 Oct 2001 10:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277398AbRJEOgy>; Fri, 5 Oct 2001 10:36:54 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:44299 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S277394AbRJEOgi>; Fri, 5 Oct 2001 10:36:38 -0400
Message-Id: <200110051435.f95EZrvw027128@pincoya.inf.utfsm.cl>
To: Juha Siltala <juha.siltala@mail.suomi.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: Re: Past CREDITS files 
In-Reply-To: Your message of "Fri, 05 Oct 2001 10:38:22 +0300."
             <20011005103822.21d1f663.juha.siltala@mail.suomi.net> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Fri, 05 Oct 2001 10:35:53 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[...]

> Now this is not too much but a couple of developments are emerging:
> checking out the geographical distribution of kernel hackers and some other
> analysis based on the info that the files yield. I'm not the one doing this
> but Dr. Silvonen (jussi.silvonen@helsinki.fi). I'm looking for a good way
> of extracting names from the kernel sources instead of CREDITS, since Dr
> Silvonen seems to be really getting into this and is data hungry now :)

Check the list of people on lkml, I think that is a much more accurate list
of "current developers" than CREDITS. Or look at who posted on the list.
You might classify by includes/doesn't include a patch, perhaps (people who
comment on a patch are helping development too... only flamers don't ;)

> I've been getting a lot of warnings (from Brian Gerst, Horst von Brand, and
> Mark Hahn and others) about the data above. For my own purposes, that is,
> to just show that linux is not "witten by Linus Torvalds in 1991" like we
> hear from the media, the data would do. But If we (Dr. Silvonen and perhaps
> I too) are going to elaborate on this, we obviously need something more
> reliable. Everyone puts their name in their files and patches right?

No... I have posted several patches, most of those that did get included
went in without my name (to be fair, they were mostly very small/simple).
Others I sent directly to the maintainers, some went in with my name on a
changelog or in the modified file(s), others without any mention at all.
Policy on this clearly varies from maintainer to maintainer (and perhaps
phase of the moon), so your idea will give data skewed at least by
subsystem.
-- 
Dr. Horst H. von Brand                Usuario #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
