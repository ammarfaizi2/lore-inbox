Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbULETQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbULETQZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 14:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbULETQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 14:16:25 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:56773 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261362AbULETQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 14:16:24 -0500
Subject: Re: Proposal for a userspace "architecture portability" library
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       libc-alpha@sources.redhat.com
In-Reply-To: <16818.23575.549824.733470@cargo.ozlabs.ibm.com>
References: <16818.23575.549824.733470@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102270346.9242.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 05 Dec 2004 18:12:28 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-12-05 at 00:53, Paul Mackerras wrote:
> Now, clearly I can do this under the GPL.  However, I think it would
> be more useful to have the library under the LGPL, which requires
> either getting the permission of the authors of the kernel files, or
> rewriting them from scratch.

Why not use the mozilla ones ? Some of them are kernel ones reused with
permission and others are reimplementations but it has a fair set of
functions.


