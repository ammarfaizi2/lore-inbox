Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271103AbTGWFCC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 01:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271104AbTGWFCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 01:02:02 -0400
Received: from h-66-167-79-70.SNVACAID.covad.net ([66.167.79.70]:49312 "EHLO
	adam.yggdrasil.com") by vger.kernel.org with ESMTP id S271103AbTGWFCA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 01:02:00 -0400
Date: Tue, 22 Jul 2003 22:12:33 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200307230512.h6N5CXQ10468@adam.yggdrasil.com>
To: andersen@codepoet.org
Subject: Re: Promise SATA driver GPL'd
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> = Jeff Garzik
>  = Erik Andersen

>> On a legal note, I would prefer that completely new drivers (i.e. no
>> copied code from other sources) be licensing in the same way as
>> libata.c.  Maintainer's preference in the end, of course, but I would
>> like to strongly encourage following libata.c's example ;-)
>
>By that I assume you mean osl-1.1 like libata.c, rather than GPL
>like ata_piix.c....  [...]

	Just to clarify, the changes in
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test1-libata1.patch.gz
appear to be covered by terms that amount of "your choice of osl-1.1
OR GPL-2."  It is the permission to use the code under the terms
of the GPL (or some other GPL compatible permissions) that allow
code to be linked into a program that contains GPL'ed code, like
the Linux kernel, assuming the Free Software Foundation's statements
that osl-1.1 is GPL-incompatible are correct
(http://www.gnu.org/licenses/license-list.html).  So, please remember
to keep "or GPLv2" provision or something similar to keep your
contribution GPL compatible.

	I'm glad to see more serial ATA support now that SATA
drives are becoming common, and I'm also looking forward to
giving libata a whirl.  Thank you both for your contributions.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
