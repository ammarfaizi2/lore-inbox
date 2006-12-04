Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936888AbWLDOSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936888AbWLDOSz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936887AbWLDOSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:18:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18061 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936885AbWLDOSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:18:54 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061204132916.GA24634@flint.arm.linux.org.uk> 
References: <20061204132916.GA24634@flint.arm.linux.org.uk>  <1165084076.24604.56.camel@localhost.localdomain> <20061202184035.GL3078@ftp.linux.org.uk> <200612022243.58348.zippel@linux-m68k.org> <20061202215941.GN3078@ftp.linux.org.uk> <Pine.LNX.4.64.0612022306360.1867@scrub.home> <20061202224018.GO3078@ftp.linux.org.uk> <Pine.LNX.4.64.0612022345520.1867@scrub.home> <20061203102108.GA1724@elf.ucw.cz> <26864.1165230869@redhat.com> <29346.1165237409@redhat.com> 
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       Roman Zippel <zippel@linux-m68k.org>, Al Viro <viro@ftp.linux.org.uk>,
       Thomas Gleixner <tglx@linutronix.de>, Matthew Wilcox <matthew@wil.cx>,
       Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] timers, pointers to functions and type safety 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 04 Dec 2006 14:17:21 +0000
Message-ID: <9737.1165241841@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> > You've now got four copies of struct timer_list, but only one handler.
> 
> <re-insert last paragraph of my message until read, understood and
> actioned.>

I was merely correcting your assumption of what premise I was thinking of.
You thought of something unnecessarily complex.  I said nothing about what I
thought of your last suggestion.  Timer reduction patches are being worked on,
though not by me.

David
