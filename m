Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135602AbRDXN26>; Tue, 24 Apr 2001 09:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135603AbRDXN2s>; Tue, 24 Apr 2001 09:28:48 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:49421 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S135607AbRDXN2g>; Tue, 24 Apr 2001 09:28:36 -0400
Message-Id: <200104241328.f3ODSFrn011684@pincoya.inf.utfsm.cl>
To: David Woodhouse <dwmw2@infradead.org>
cc: Russell King <rmk@arm.linux.org.uk>, mythos <papadako@csd.uoc.gr>,
        linux-kernel@vger.kernel.org
Subject: Re: Can't compile 2.4.3 with agcc 
In-Reply-To: Message from David Woodhouse <dwmw2@infradead.org> 
   of "Mon, 23 Apr 2001 23:35:38 +0100." <4624.988065338@redhat.com> 
Date: Tue, 24 Apr 2001 09:28:14 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> said:
> vonbrand@inf.utfsm.cl said:
> >  Your patch (tries to) transform a compile and link time check into a
> > runtime check. Not nice.

> It transforms a broken and cryptic compile-time check into a correct and
> informative runtime check.

These "broken and cryptic" checks have been done several times now. You
could certainly add a note to this effect to the documentation on building
the kernel.

Building a known broken kernel just for the sake of "better error
reporting" is dead wrong, IMO.
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
