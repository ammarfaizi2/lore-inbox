Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270888AbTGPKXb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 06:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270887AbTGPKXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 06:23:30 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:17295 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S270878AbTGPKWZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 06:22:25 -0400
From: root@mauve.demon.co.uk
Message-Id: <200307161037.LAA01628@mauve.demon.co.uk>
Subject: Re: [Swsusp-devel] RE:Re: Thoughts wanted on merging Softwa
To: pavel@suse.cz (Pavel Machek)
Date: Wed, 16 Jul 2003 11:37:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030716083758.GA246@elf.ucw.cz> from "Pavel Machek" at Jul 16, 2003 10:37:58 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hi!
> 
> > Thus wrote pavel@ucw.cz:
> > > Anyway, depending on acpi is wrong and needs to be fixed in 2.7.
> > 
> > Could you elaborate on that? Do you mean S4, or any suspend state in
> > general?
> 
> It would be nice to have arch-neutral way to enter suspend to ram and
> suspend to disk. Being arch-neutral, it may not depend on ACPI.

Taking this in a slightly different direction.

It would be even nicer to be able to be able to migrate machine images
between machines.
How identical do machines have to be before it's no longer just a case
of copying the file?
Identical make of RAM, same CPU model, same BIOS version, with the PCI and 
USB things connected to the same slots in the same way?
Or is it a little looser?
