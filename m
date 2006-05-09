Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751759AbWEILXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbWEILXA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 07:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbWEILXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 07:23:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45499 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751759AbWEILW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 07:22:59 -0400
Date: Tue, 9 May 2006 13:22:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: [PATCH -mm] swsusp: support creating bigger images
Message-ID: <20060509112225.GA8816@elf.ucw.cz>
References: <200605021200.37424.rjw@sisk.pl> <20060509003334.70771572.akpm@osdl.org> <200605091219.17386.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605091219.17386.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > EXTRA_PAGES is not a well-chosen identifier.  Please choose something
> > within the swsusp "namespace", if there's such a thing.
> 
> Unfortunately there's not any, but I'll try to invent a better
> name. :-)

PM_EXTRA_PAGES would probably be acceptable, as would
SUSPEND_EXTRA_PAGES be...
							Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
