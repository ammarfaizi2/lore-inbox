Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271104AbTGWFVX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 01:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271105AbTGWFVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 01:21:23 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:49170
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S271104AbTGWFVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 01:21:21 -0400
Date: Tue, 22 Jul 2003 22:28:26 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: andersen@codepoet.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: Promise SATA driver GPL'd
In-Reply-To: <200307230512.h6N5CXQ10468@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.10.10307222219300.10927-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To bad people do not see the lameness of GPL and the superior quality of
OSL.  The former forces the author to assign copyright to FSF to gain
legal services or write the check out of their own pocket.  The latter
provides a means to allow the author to feed the sharks and protect the
interest of the OSC.

GPL == Author pays legal costs regardless.
OSL == Provisions for legals to be recovered.

This is one of the reasons I quit publish GPL because the costs I have to
defend my works in the past are going to be heavy, and I am tired of
having stuff stolen.

So switching to OSL for the kernel as a whole is a no brainer.
Leaving it as GPL is a way to promote thieft.

Simple facts, and do not give a rip about arguements against OSL in favor
of GPL because they all are lose when it comes down to the issue of
defending the interest of the "author" and the OSC (open source community)

A vote for continuing GPL in the kernel is a promote and enable the
thieves on the world.  Narrow vision of a utopian stupidity without a
means to kick arse to defend the broader issues is ...

Adam I like you, and your politics and ideas of GPL suck. :-)

Cheers

Andre Hedrick
LAD Storage Consulting Group

On Tue, 22 Jul 2003, Adam J. Richter wrote:

> >> = Jeff Garzik
> >  = Erik Andersen
> 
> >> On a legal note, I would prefer that completely new drivers (i.e. no
> >> copied code from other sources) be licensing in the same way as
> >> libata.c.  Maintainer's preference in the end, of course, but I would
> >> like to strongly encourage following libata.c's example ;-)
> >
> >By that I assume you mean osl-1.1 like libata.c, rather than GPL
> >like ata_piix.c....  [...]
> 
> 	Just to clarify, the changes in
> ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test1-libata1.patch.gz
> appear to be covered by terms that amount of "your choice of osl-1.1
> OR GPL-2."  It is the permission to use the code under the terms
> of the GPL (or some other GPL compatible permissions) that allow
> code to be linked into a program that contains GPL'ed code, like
> the Linux kernel, assuming the Free Software Foundation's statements
> that osl-1.1 is GPL-incompatible are correct
> (http://www.gnu.org/licenses/license-list.html).  So, please remember
> to keep "or GPLv2" provision or something similar to keep your
> contribution GPL compatible.
> 
> 	I'm glad to see more serial ATA support now that SATA
> drives are becoming common, and I'm also looking forward to
> giving libata a whirl.  Thank you both for your contributions.
> 
> Adam J. Richter     __     ______________   575 Oroville Road
> adam@yggdrasil.com     \ /                  Miplitas, California 95035
> +1 408 309-6081         | g g d r a s i l   United States of America
>                          "Free Software For The Rest Of Us."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

