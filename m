Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261646AbSKXT7Y>; Sun, 24 Nov 2002 14:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbSKXTz6>; Sun, 24 Nov 2002 14:55:58 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3844 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261613AbSKXTza>;
	Sun, 24 Nov 2002 14:55:30 -0500
Date: Sat, 23 Nov 2002 20:57:20 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Ducrot Bruno <poup@poupinou.org>, Dave Jones <davej@codemonkey.org.uk>,
       Margit Schubert-While <margit@margit.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20 ACPI
Message-ID: <20021123195720.GA310@elf.ucw.cz>
References: <4.3.2.7.2.20021119134830.00b53680@mail.dns-host.com> <20021119130728.GA28759@suse.de> <20021119142731.GF27595@poup.poupinou.org> <20021119164550.GQ11952@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021119164550.GQ11952@fs.tum.de>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >...
> > I disagree with you.  It introduces more enhancements,
> > and more bugfix than the current code.  I admit that tt
> > could introduce some news bugs, but in the balance it
> > should be more stable than before.
> >...
> 
> It's not "in the balance". 2.4 is a stable kernel series. The problem is
> that if you switch from one stable kernel series to another
> (e.g. 2.2 -> 2.4) on a production machine you know that you have to
> check whether everything works as before you upgrade your production
> machines. This can take quite some time. Within a stable kernel series
> everything that worked in earlier kernels within this series should work
> in future kernels in this kernel series. Don't forget that e.g. a
> fixed security problem might force people to do a quick upgrade of
> production machines to the latest kernel in this series.

ACPI is marked experimental (and it *is* experimental), if you run it
on production machine you loose.

								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
