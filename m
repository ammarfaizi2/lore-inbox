Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937391AbWLDVEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937391AbWLDVEB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 16:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937389AbWLDVEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 16:04:01 -0500
Received: from jdi.jdi-ict.nl ([82.94.239.5]:60683 "EHLO jdi.jdi-ict.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937392AbWLDVEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 16:04:00 -0500
Date: Mon, 4 Dec 2006 22:03:39 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdi-ict.nl>
X-X-Sender: igmar@jdi.jdi-ict.nl
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, erich <erich@areca.com.tw>
Subject: Re: 2.6.16.32 stuck in generic_file_aio_write()
In-Reply-To: <Pine.LNX.4.58.0612010926030.31655@jdi.jdi-ict.nl>
Message-ID: <Pine.LNX.4.58.0612042201001.14643@jdi.jdi-ict.nl>
References: <Pine.LNX.4.58.0611291329060.18799@jdi.jdi-ict.nl>
 <20061130212248.1b49bd32.akpm@osdl.org> <Pine.LNX.4.58.0612010926030.31655@jdi.jdi-ict.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.1.12 (jdi.jdi-ict.nl [127.0.0.1]); Mon, 04 Dec 2006 22:03:41 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It's rather large, but for those who want to look at it : 
> http://www.jdi-ict.nl/plain/serial-28112006.txt

The same problem, this time with 2.6.19. I've done a show tasks, a show 
locks, a show regs, and after that, a sync + reboot :)

Log is at http://www.jdi-ict.nl/plain/serial-04122006.txt .

If anyone needs more info : please tell me.

Regards,


	Igmar
