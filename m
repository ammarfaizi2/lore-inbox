Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030815AbWK3RLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030815AbWK3RLO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 12:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030822AbWK3RLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 12:11:14 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57504 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030816AbWK3RLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 12:11:14 -0500
Date: Thu, 30 Nov 2006 18:11:02 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Christoph Schmid <chris@schlagmichtod.de>, linux-kernel@vger.kernel.org
Subject: Re: is there any Hard-disk shock-protection for 2.6.18 and above?
Message-ID: <20061130171102.GC1860@elf.ucw.cz>
References: <455DAF74.1050203@schlagmichtod.de> <20061121205124.GB4199@ucw.cz> <41840b750611231026r790cd327q7e48ebd99f9b9350@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750611231026r790cd327q7e48ebd99f9b9350@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Does hdaps work for you, btw? It gave all zeros on my x60, iirc.
> 
> Yes, vanilla hdaps is broken. It blindly issues commands to the
> embedded controller without following the protocol or checking the
> status. The patched version in the tp_smapi package fixes it.

Is there a way to extract minimal patch? ...the kind that is trivial
enough so that akpm does accepts it...? 
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
