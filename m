Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWJBNKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWJBNKa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 09:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWJBNKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 09:10:30 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41625 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932291AbWJBNK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 09:10:29 -0400
Date: Mon, 2 Oct 2006 15:10:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: James Morris <jmorris@namei.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, Cory Olmo <colmo@TrustedCS.com>
Subject: Re: [PATCH] SELinux - support mls categories for context mounts
Message-ID: <20061002131026.GC13617@elf.ucw.cz>
References: <Pine.LNX.4.64.0609281529140.28065@d.namei> <20060928124539.71aa5ee8.akpm@osdl.org> <Pine.LNX.4.64.0609281559500.28120@d.namei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609281559500.28120@d.namei>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The proposed solution is to allow/require the SELinux context option 
> > > specified to mount to use quotes when the context contains a comma.
> > 
> > None of this seems to be documented anywhere.  I expect the people who
> > actually work on this stuff make a pretty tight group, but...
> 
> Context mounts have been covered in magazines and blogs, and other docs, 
> e.g.

But kernel documentation should go to linux/Documentation, right?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
