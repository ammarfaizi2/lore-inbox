Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWE3OuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWE3OuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 10:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWE3OuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 10:50:24 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3750 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932298AbWE3OuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 10:50:23 -0400
Date: Tue, 30 May 2006 16:49:37 +0200
From: Pavel Machek <pavel@suse.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>,
       Netdev list <netdev@vger.kernel.org>, Jirka Lenost Benc <jbenc@suse.cz>,
       pe1rxq@amsat.org
Subject: Re: zd1201 failure on sharp zaurus explained
Message-ID: <20060530144937.GD27794@elf.ucw.cz>
References: <20060530132054.GA9780@elf.ucw.cz> <200605301611.02984.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200605301611.02984.oliver@neukum.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 30-05-06 16:11:02, Oliver Neukum wrote:
> Am Dienstag, 30. Mai 2006 15:20 schrieb Pavel Machek:
> > 2) usb problem, probably. Should not usb core detect that card
> > requires too much juice and refuse to power it up?
> 
> Does your hub correctly report whether it is plugged in?

No idea; how do I tell?

But zaurus tries to power the wlan card even if it is directly plugged
in. wlan card there comunicates with the computer but not with the
wireless part...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
