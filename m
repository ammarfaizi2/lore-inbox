Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbVDFVWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbVDFVWZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 17:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVDFVWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 17:22:25 -0400
Received: from web88010.mail.re2.yahoo.com ([206.190.37.197]:43629 "HELO
	web88010.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262331AbVDFVWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 17:22:21 -0400
Message-ID: <20050406212221.75716.qmail@web88010.mail.re2.yahoo.com>
Date: Wed, 6 Apr 2005 17:22:21 -0400 (EDT)
From: Shawn Starr <shawn.starr@rogers.com>
Subject: Re: [2.6.12-rc1][ACPI][suspend] /proc/acpi/sleep vs /sys/power/state issue - 'standby' on a laptop
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, acpi-devel@lists.sourceforge.net
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yeah, I can do that, I don't need angry programmers
chasing after me :-)

Shawn.

--- Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
> 
> > So nobody minds if I make this into a CONFIG
> option marked as Deprecated? :)
> 
> Actually it should probably go through
> 
> Documentation/feature-removal-schedule.txt
> 
> ...and give it *long* timeout, since it is API
> change.
> 									Pavel
> -- 
> People were complaining that M$ turns users into
> beta-testers...
> ...jr ghea gurz vagb qrirybcref, naq gurl frrz gb
> yvxr vg gung jnl!
> 
