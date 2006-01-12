Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbWALOjD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbWALOjD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030421AbWALOjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:39:03 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38343 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030411AbWALOjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:39:01 -0500
Date: Thu, 12 Jan 2006 15:38:51 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Place for userland swsusp parts
Message-ID: <20060112143851.GB9752@elf.ucw.cz>
References: <20060111221511.GA8223@elf.ucw.cz> <200601120819.42512.ncunningham@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200601120819.42512.ncunningham@linuxmail.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 12-01-06 08:19:42, Nigel Cunningham wrote:
> Hi.
> 
> On Thursday 12 January 2006 08:15, Pavel Machek wrote:
> > Hi!
> >
> > Is there some place where we could  put userland swsusp parts under
> > version control?
> >
> > swsusp.sf.net looks like possible place, but it has been in use by
> > suspend2... Is it still being used? If not, would it be possible to
> > "hijack" it for swsusp development?
> 
> It's not still being used (we have suspend2.net now). The only problem I see 
> with that is that it still has all the old suspend2 stuff and Sourceforge 
> make it really hard to clear out a project's files. You were talking about 
> calling it uswsusp or something like that. How about starting a 
> uswsusp.sf.net?

Rafael, do you have repository to place userland parts in, or should I
start uswsusp.sf.net project, or do you want to do it?
								Pavel
-- 
Thanks, Sharp!
