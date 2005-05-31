Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVEaAyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVEaAyt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 20:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVEaAyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 20:54:49 -0400
Received: from mail.dvmed.net ([216.237.124.58]:59116 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261785AbVEaAym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 20:54:42 -0400
Message-ID: <429BB5CB.2020708@pobox.com>
Date: Mon, 30 May 2005 20:54:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: libata dev guide updated
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.5 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Just made a run through the libata docs, updating them
	for the latest hooks and filling in missing details like
	locking/context documentation. I've been playing with lulu.com
	self-publishing, and published this newly updated libata Developer's
	Guide there as a short book (92 pages):
	http://www.lulu.com/content/130446 [...] 
	Content analysis details:   (0.5 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.5 TO_ADDRESS_EQ_REAL     To: repeats address as real name
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just made a run through the libata docs, updating them for the latest 
hooks and filling in missing details like locking/context documentation. 
I've been playing with lulu.com self-publishing, and published this 
newly updated libata Developer's Guide there as a short book (92 pages):
	http://www.lulu.com/content/130446

I think the muddy road on the front cover is apropos :)

This guide continues to be open source -- just run "make pdfdocs" in the 
kernel source tree.

A PDF of the book is available for free on lulu.com or at 
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata.pdf or by 
running "make pdfdocs" (or "make psdocs", "make htmldocs", ...).

The source code for the guide is in the kernel source tree, with new 
additions in the 'docs' branch of 
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git


