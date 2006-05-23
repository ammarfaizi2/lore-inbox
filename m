Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWEWWzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWEWWzG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 18:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWEWWzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 18:55:06 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22996 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932267AbWEWWzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 18:55:05 -0400
Date: Wed, 24 May 2006 00:35:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.17-rc4-mm3: scary warning from pdflush
Message-ID: <20060523223515.GA1571@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Not sure, I'm getting this during resume:

May 24 00:34:01 amd kernel: Restarting tasks...pdflush: bogus wakeup!
May 24 00:34:01 amd kernel:  done
May 24 00:34:01 amd kernel: Thawing cpus ...

Is it expected?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
