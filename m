Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVBTLyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVBTLyf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 06:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVBTLyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 06:54:35 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:15050 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261820AbVBTLye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 06:54:34 -0500
Subject: Re: IBM Thinkpad G41 PCMCIA problems [Was: Yenta TI: ... no PCI
	interrupts. Fish. Please report.]
From: Steven Rostedt <rostedt@goodmis.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
In-Reply-To: <20050220082226.A7093@flint.arm.linux.org.uk>
References: <1108858971.8413.147.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0502191648110.14176@ppc970.osdl.org>
	 <1108863372.8413.158.camel@localhost.localdomain>
	 <20050220082226.A7093@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sun, 20 Feb 2005 06:54:07 -0500
Message-Id: <1108900447.8413.170.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-20 at 08:22 +0000, Russell King wrote:

> Your BIOS is broken.  You probably have 1GB of RAM which extends from
> 0x00000000 to 0x40000000.  

Just to leave no doubt. Yes, I have a Gig of RAM.

-- Steve

