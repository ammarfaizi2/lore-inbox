Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265636AbTF2L3f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 07:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265637AbTF2L3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 07:29:35 -0400
Received: from gibson.mw.luc.edu ([147.126.62.56]:18841 "EHLO
	gibson.mw.luc.edu") by vger.kernel.org with ESMTP id S265636AbTF2L3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 07:29:34 -0400
Date: Sun, 29 Jun 2003 06:49:44 -0500 (CDT)
From: Fluke <fluke@gibson.mw.luc.edu>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-poweredge@dell.com, <linux-kernel@vger.kernel.org>
Subject: Re: Dell vs. GPL
In-Reply-To: <Pine.LNX.4.10.10306282112400.1116-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.44.0306290620010.29249-100000@gibson.mw.luc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jun 2003, Andre Hedrick wrote:

> First since it effects ATA it is my issue for the most part.
> You have no stake or issue to pursue GPL violations if there are any.
> Three, until you have copyright status, you have not right to invoke GPL
> unless you are a customer of Dell, and are not bound by a contract to
> Dell.  So get your facts first.

Ok.  Here is my facts:
  - binary code resulting from the GPL work "modutils" was redistributed 
without the source code or written offer of source code
  - binary code resulting from the Linux kernel GPL work "knfs" was
redistributed without the source code or written offer of source code
  - binary code resulting from the Linux kernel GPL work "usb-storage" was 
redistributed without the source code or written offer of source code
  - binary code resulting from the Linux kernel GPL work "ext2fs" was
redistributed without the source code or written offer of source code
  - binary code resulting from the Linux kernel GPL work "initrd" was 
redistributed without the source code or written offer of source code
  - binary code resulting from ....

  I fail to see how this only violates the copyright on ATA unless your
"facts" include the myth that the only source code that needs to be
provided is the portion changed.  The actual wording of the GPL requires a
minimum of passing along a written offer for the *complette* source code
for all work redistributed.

  I would have accepted a README that stated that they provided a patch
*and* equivalent access to the rest of the source code was available at
ftp://ftp.dell.com/... but there is no equivalent access to the complette
source code (even across multiple files) on Dell's ftp site.  Since this
is non-commerical redistribution, I would have accepted a README that
stated they provide a patch *and* a pointer to RedHat's SRPM.  But there
is *NO* written offer to the complette source code.

  This redistribution appears to violate the license terms on more than
just ATA including my contributions, since it is more than just ATA which
is covered by the GPL and provided in binary only form without a written
offer of source code.  This includes my contributions to ide-cdrom of
which I never signed copyright control over to anyone else.

  And as long as we are now taken to giving flippant advice, before you
respond again you might want to "get your facts first."  Or should I say
get your facts *straight* first.

