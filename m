Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbUBHD5M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 22:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUBHD5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 22:57:12 -0500
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:16653 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S262048AbUBHD5K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 22:57:10 -0500
Date: Sun, 8 Feb 2004 03:14:20 +0100 (CET)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: IPV4 as module?
In-Reply-To: <20040205122921.GB28571@lug-owl.de>
Message-ID: <Pine.LNX.4.58L.0402080257060.29247@rudy.mif.pg.gda.pl>
References: <20040204200610.GB3802@localhost.localdomain>
 <20040205122921.GB28571@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Feb 2004, Jan-Benedict Glaw wrote:

> On Wed, 2004-02-04 23:06:10 +0300, Andrey Borzenkov <arvidjaar@mail.ru>
> wrote in message <20040204200610.GB3802@localhost.localdomain>:
> > Any technical reaon IPV4 cannot be built as module? Current kernel
> > barely fits on floopy (even with IDE as module); factoring out IPV4
> > would allow to reduce size even more.
> 
> Some hard work need to be done to do that, but why shouldn't a kernel
> fit onto a floppy? My vmlinuz'es are at about 600 to 900 KB for i386 and
> a floppy can handle nearly about twice that size...

Better will be ask why you must recompile kernel for add ipv4 abilities
if you uses (olny) for example ipv6 stack ? :)

kloczek
PS. Many modern PCs wave now only CD drive .. one CD can fit much 
more than kernel image and all kernel modules. So step your quostion path 
it will be "much more correct" ask why the hell kernel is (still ?) 
modular (?) 8^>
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
