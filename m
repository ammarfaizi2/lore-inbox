Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752117AbWFWWMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbWFWWMN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 18:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbWFWWMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 18:12:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4307 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752118AbWFWWML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 18:12:11 -0400
Date: Sat, 24 Jun 2006 00:11:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Frederik Deweerdt <deweerdt@free.fr>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org, linux-pm@osdl.org,
       stern@rowland.harvard.edu
Subject: Re: [linux-pm] swsusp regression [Was: 2.6.17-mm1]
Message-ID: <20060623221117.GA2497@elf.ucw.cz>
References: <20060621034857.35cfe36f.akpm@osdl.org> <4499BE99.6010508@gmail.com> <20060621221445.GB3798@inferi.kami.home> <20060622061905.GD15834@kroah.com> <20060622004648.f1912e34.akpm@osdl.org> <20060622160403.GB2539@slug> <20060622092506.da2a8bf4.akpm@osdl.org> <20060623090206.GA2234@slug> <20060623091016.GE4940@elf.ucw.cz> <20060623194100.GA3812@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623194100.GA3812@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-06-23 20:41:01, Russell King wrote:
> On Fri, Jun 23, 2006 at 11:10:21AM +0200, Pavel Machek wrote:
> > Serial console is currently broken by suspend, resume. _But_ I have a
> > patch I'd like you to try.... pretty please?
> 
> Did you bother trying my patch, which was done the Right(tm) way?
> There wasn't any feedback on it so I can only assume not.

(I actually forwarded him your patch in private email).
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
