Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWHBUWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWHBUWq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 16:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWHBUWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 16:22:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8392 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932219AbWHBUWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 16:22:46 -0400
Date: Wed, 2 Aug 2006 22:22:32 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] swsusp: Fix alloc_pagedir
Message-ID: <20060802202232.GE8124@elf.ucw.cz>
References: <200608021842.21774.rjw@sisk.pl> <200608021857.35042.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608021857.35042.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Get rid of the FIXME in kernel/power/snapshot.c#alloc_pagedir() and
> simplify the functions called by it.

ACK.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
