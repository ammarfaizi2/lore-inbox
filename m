Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267510AbSKQOqH>; Sun, 17 Nov 2002 09:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267511AbSKQOqH>; Sun, 17 Nov 2002 09:46:07 -0500
Received: from host194.steeleye.com ([66.206.164.34]:64267 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267510AbSKQOqG>; Sun, 17 Nov 2002 09:46:06 -0500
Message-Id: <200211171453.gAHEqxV11551@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Marc Zyngier <mzyngier@freesurf.fr>, Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com
Subject: Re: [PATCH] sysfs stuff for eisa bus [1/3]
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 17 Nov 2002 08:52:58 -0600
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>>> "Jeff" == Jeff Garzik <jgarzik@pobox.com> writes:

> Jeff> Jeff, who would also like to see "sysfs stuff for MCA" too :)

> If someone ships me an MCA box, I'll do it ;-).
> I have (or have access to) tons of MCA cards, but no supported MCA
> machine (only old POWER boxes...).

I've actually already begun the MCA sysfs stuff (although I'll rework it to 
model on the EISA pieces---far easier than trying to copy pci, which was where 
I began...).

James



