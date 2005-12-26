Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVLZUdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVLZUdT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 15:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVLZUdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 15:33:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10164 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932137AbVLZUdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 15:33:19 -0500
Date: Mon, 26 Dec 2005 21:32:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jaco Kroon <jaco@kroon.co.za>,
       jason@stdbev.com, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
       s0348365@sms.ed.ac.uk
Subject: Re: recommended mail clients
Message-ID: <20051226203252.GB1974@elf.ucw.cz>
References: <43AF7724.8090302@kroon.co.za> <43AFB005.50608@kroon.co.za> <1135607906.5774.23.camel@localhost.localdomain> <200512261535.09307.s0348365@sms.ed.ac.uk> <1135619641.8293.50.camel@mindpipe> <0f197de4ee389204cc946086d1a04b54@stdbev.com> <1135621183.8293.64.camel@mindpipe> <43B03658.9040108@kroon.co.za> <43B041FA.8000404@pobox.com> <1135625550.8293.86.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1135625550.8293.86.camel@mindpipe>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I would NAK such a patch.
> > 
> > Andrew Morton described a way to do it, some method using x cut buffers, 
> > IIRC.
> > 
> > The best thing to do is use a custom script, though.  Other mailers can 
> > be annoying as well, with regards to the References header, for example. 
> >   And pine is awful, encoding plain text as base64.
> 
> For a maintainer who patch bombs LKML constantly a custom script is best
> but for the casual contributor their mailer should just work.
> 
> The default Gnome and KDE mail clients work OK so why don't we just try
> to get Thunderbird fixed or at least warn about it?  Casual contributors
> are very likely to read SubmittingPatches.
> 
> I'm not trying to find the one true solution I'd just like to end the
> constant low grade noise (and higher bug fix latency!) of "Please
> resend, your patch is linewrapped" every few days.

Well, l-k has some rather extensive spam traps, right? What about
adding "if it contains patch, it should be well-formed patch" into the
list?

That way user would get bounce from the mailinglist, telling him how
not to damage the patches...

								Pavel
-- 
Thanks, Sharp!
