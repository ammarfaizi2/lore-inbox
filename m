Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289655AbSAOVAa>; Tue, 15 Jan 2002 16:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290282AbSAOVAU>; Tue, 15 Jan 2002 16:00:20 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:21231 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S289655AbSAOVAN>; Tue, 15 Jan 2002 16:00:13 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E16QZg2-000616-00@the-village.bc.nu> 
In-Reply-To: <E16QZg2-000616-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: root@chaos.analogic.com, marco@esi.it (Marco Colombo),
        Thomas.Duffy.99@alumni.brown.edu (Thomas Duffy),
        linux-kernel@vger.kernel.org (Linux Mailing List)
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Jan 2002 20:59:45 +0000
Message-ID: <24095.1011128385@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
> > Really???  Have you ever tried this? RedHat provides a directory
> > of random patches that won't patch regardless of the order in
> > which you attempt patches (based upon date-stamps on patches or
> > date-stamps on files). It's like somebody just copied in some
> > junk, thinking nobody would ever bother.

> They apply nicely and the spec file defines which to apply and when.
> The srpm and rpm are generated together. 

And just in case you're too incompetent or lazy to manage this, there's also
a kernel-source package which contains the resulting source tree, with all
the patches already applied to it.

--
dwmw2


