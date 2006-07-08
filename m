Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWGHLOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWGHLOW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 07:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWGHLOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 07:14:21 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20943 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964776AbWGHLOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 07:14:19 -0400
Date: Sat, 8 Jul 2006 13:13:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Bojan Smojver <bojan@rexursive.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Jan Rychter <jan@rychter.com>,
       Avuton Olrich <avuton@gmail.com>, linux-kernel@vger.kernel.org,
       Olivier Galibert <galibert@pobox.com>,
       suspend2-devel@lists.suspend2.net, grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Message-ID: <20060708111359.GJ1700@elf.ucw.cz>
References: <20060627133321.GB3019@elf.ucw.cz> <20060707215656.GA30353@dspnet.fr.eu.org> <20060707232523.GC1746@elf.ucw.cz> <200607080933.12372.ncunningham@linuxmail.org> <20060708002826.GD1700@elf.ucw.cz> <m2d5cg1mwy.fsf@tnuctip.rychter.com> <1152353698.2555.11.camel@coyote.rexursive.com> <1152355318.3120.26.camel@laptopd505.fenrus.org> <1152357077.2088.4.camel@beast.rexursive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152357077.2088.4.camel@beast.rexursive.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2006-07-08 21:11:17, Bojan Smojver wrote:
> On Sat, 2006-07-08 at 12:41 +0200, Arjan van de Ven wrote:
> 
> > What is worse, these suspend systems will inevitable have
> > different requirements on the rest of the kernel, and will thus
> > complicate the heck out of it for the rest of the developers.
> 
> My (user level) understanding is that built in swsusp and Suspend2 use
> the same (or almost the same) machinery in the rest of the kernel to do
> the work. I'm sure Nigel, Pavel and others can confirm or deny this.

It is pretty similar, yes.

> > No fancy shnazy GUI inside the kernel, but SIMPLE.
> 
> AFAIK, none of the solutions have GUI inside the kernel.

Then you need to read suspend2 patch again.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
