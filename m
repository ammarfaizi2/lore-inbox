Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbTEHU7M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 16:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTEHU7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 16:59:12 -0400
Received: from palrel13.hp.com ([156.153.255.238]:7376 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262106AbTEHU7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 16:59:11 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16058.51215.725945.667247@napali.hpl.hp.com>
Date: Thu, 8 May 2003 14:11:43 -0700
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
In-Reply-To: <1052426022.1677.3.camel@laptop.fenrus.com>
References: <20030507104008$12ba@gated-at.bofh.it>
	<200305071154.h47BsbsD027038@post.webmailer.de>
	<20030507124113.GA412@elf.ucw.cz>
	<20030507135600.A22642@infradead.org>
	<1052318339.9817.8.camel@rth.ninka.net>
	<20030508151643.GO679@phunnypharm.org>
	<20030508193430.GC933@elf.ucw.cz>
	<20030508192730.GX679@phunnypharm.org>
	<16058.48490.620518.27093@napali.hpl.hp.com>
	<1052426022.1677.3.camel@laptop.fenrus.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 08 May 2003 22:33:42 +0200, Arjan van de Ven <arjanv@redhat.com> said:

  >> Definitely.  I turn it off on a regular basis and expect to use it
  >> even less in the future.

  Arjan> working on a qemu port to ia64 ?

Who, me?  I know better than that.

Last time I worked on x86 emulation was on Alpha for BIOS emulation.
It wasn't fun then.

	--david
