Return-Path: <linux-kernel-owner+w=401wt.eu-S932730AbWLZRPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932730AbWLZRPm (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 12:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932727AbWLZRPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 12:15:42 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34699 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932725AbWLZRPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 12:15:41 -0500
Date: Tue, 26 Dec 2006 18:15:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Fabio Comolli <fabio.comolli@gmail.com>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: BUG: scheduling while atomic - Linux 2.6.20-rc2-ga3d89517
Message-ID: <20061226171531.GC7600@elf.ucw.cz>
References: <b637ec0b0612240553n28b252c4p4c1559da794e646c@mail.gmail.com> <87psa9z0wu.fsf@duaron.myhome.or.jp> <b637ec0b0612251102w2bb4a4c1ifc78df1193879c6f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b637ec0b0612251102w2bb4a4c1ifc78df1193879c6f@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> some days and will let you know if the problem represents. Please note
> that it happened only twice and I don't have any clue on how to
> reproduce it.
> 
> I added Pavel and Rafael to CC-list because for the first time in at
> least six months my laptop failed to resume after suspend-to-disk
> (userland tools) with this kernel. Guys, do you think that this
> failure could be related to this BUG?

everything is possible, but this one does not seem too likely. Is
failure reproducible?

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
