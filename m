Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932797AbWF0LMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932797AbWF0LMJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 07:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933398AbWF0LMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 07:12:09 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21477 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932797AbWF0LMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 07:12:08 -0400
Date: Tue, 27 Jun 2006 13:09:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 2/2] [Suspend2] Freezer upgrade.
Message-ID: <20060627110933.GA11763@elf.ucw.cz>
References: <20060626163850.10345.13807.stgit@nigel.suspend2.net> <20060626163856.10345.14073.stgit@nigel.suspend2.net> <200606262201.09687.rjw@sisk.pl> <200606270848.55475.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606270848.55475.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > This patch represents the Suspend2 upgrades to the freezer
> > > implementation. Due to recent changes in the vanilla version, I should be
> > > able to greatly reduce the size of this patch. TODO.
> >
> > So I assume the patch will change in the future.
> 
> This is after the changes. Sorry - forgot to update the comment.

Also please explain why we want those patches. "upgrades the freezer"
is not good enough reason to apply a patch.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
