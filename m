Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWJDVf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWJDVf2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWJDVf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:35:28 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36264 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751159AbWJDVfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:35:25 -0400
Date: Wed, 4 Oct 2006 23:35:21 +0200
From: Pavel Machek <pavel@ucw.cz>
To: koos vriezen <koos.vriezen@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.18 break scratchbox
Message-ID: <20061004213521.GA8667@elf.ucw.cz>
References: <d4e708d60610030759h23a037aega70acb44bff1b524@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4e708d60610030759h23a037aega70acb44bff1b524@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hit by http://bugzilla.scratchbox.org/bugzilla/show_bug.cgi?id=279 I
> wondered why such
> a change that could break existing setups entered 2.6.18.
> Now I can peek through '/proc/<pid of process outside chroot env w/ my
> UID>/root' into the
> box's root (and that's why scratchbox is broken now).

File bug at bugzilla.kernel.org :-).

I'm afraid we did not know about this ABI change, and noone using
scratchbox tested 2.6.18-rcX...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
