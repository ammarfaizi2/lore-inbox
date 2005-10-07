Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750849AbVJGH3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbVJGH3O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 03:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbVJGH3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 03:29:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:21197 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750849AbVJGH3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 03:29:13 -0400
Date: Fri, 7 Oct 2005 09:28:35 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Suspend to RAM broken with 2.6.13
Message-ID: <20051007072835.GG27711@elf.ucw.cz>
References: <1127347633.25357.49.camel@idefix.homelinux.org> <20050923163200.GC8946@openzaurus.ucw.cz> <1128663145.14284.85.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1128663145.14284.85.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 07-10-05 15:32:25, Jean-Marc Valin wrote:
> Hi,
> 
> I've done some further testing on suspend to RAM and it seems like it
> got broken for me between 2.6.11 and 2.6.12. Does that help narrowing
> down the problem?

Well, you'd have to track it down in a bit more specific way. If you
can narrow it down to specific day, or even better with binary search,
it will help.
								Pavel

> Le vendredi 23 septembre 2005 ? 18:32 +0200, Pavel Machek a écrit :
> > Hi!
> > 
> > > I'm experiencing problems with suspend to RAM on my Dell D600 laptop.
> > > When I run Ubuntu's 2.6.10 kernel I have no problem with suspend to RAM.
> > > However, when I run 2.6.13, my laptop sometimes doesn't wake up. It
> > > seems like the longer my uptime, the more likely the problem is to occur
> > > (which makes it hard to reproduce sometimes). This happens even with a
> > > non-preempt kernel.
> > 
> > Check if it works with minimal drivers and non-preemptible kernel...



-- 
if you have sharp zaurus hardware you don't need... you know my address
