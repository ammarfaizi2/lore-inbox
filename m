Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVJJIyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVJJIyQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 04:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVJJIyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 04:54:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30429 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750764AbVJJIyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 04:54:16 -0400
Date: Mon, 10 Oct 2005 10:54:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Suspend to RAM broken with 2.6.13
Message-ID: <20051010085402.GA2369@elf.ucw.cz>
References: <1127347633.25357.49.camel@idefix.homelinux.org> <20050923163200.GC8946@openzaurus.ucw.cz> <1128663145.14284.85.camel@localhost.localdomain> <20051007072835.GG27711@elf.ucw.cz> <1128678649.14284.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1128678649.14284.93.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 07-10-05 19:50:49, Jean-Marc Valin wrote:
> > > I've done some further testing on suspend to RAM and it seems like it
> > > got broken for me between 2.6.11 and 2.6.12. Does that help narrowing
> > > down the problem?
> > 
> > Well, you'd have to track it down in a bit more specific way. If you
> > can narrow it down to specific day, or even better with binary search,
> > it will help.
> 
> Any tip on which version to try first, i.e. when were potentially
> problematic patches merged? Keep in mind that it can take several
>days

No ideas, 2.6.12 is *long* ago :-(.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
