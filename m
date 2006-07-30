Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWG3Lat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWG3Lat (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 07:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWG3Lat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 07:30:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60604 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932240AbWG3Las (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 07:30:48 -0400
Date: Sun, 30 Jul 2006 13:30:36 +0200
From: Pavel Machek <pavel@suse.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Jirka Lenost Benc <jbenc@suse.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com
Subject: Re: ipw3945 status
Message-ID: <20060730113036.GK1920@elf.ucw.cz>
References: <20060730104042.GE1920@elf.ucw.cz> <20060730112827.GA25540@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730112827.GA25540@srcf.ucam.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'm unfortunate enough to have x60 with ipw card. Card works okay, but
> > driver is 16K LoC and needs binary daemon (ugh). Plus, it lives as an
> > external module...
> 
> I have a mostly working replacement for the binary daemon, but it causes 
> the firmware to crash at the point where it triggers an association. If 
> anyone's keen on trying to figure out what's up, I'll clean up the code 
> and stick it somewhere.

I can't promise anything, but yes, seeing that code would be great.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
