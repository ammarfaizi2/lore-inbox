Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWEXWwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWEXWwa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 18:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWEXWwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 18:52:30 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16005 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964789AbWEXWwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 18:52:30 -0400
Date: Thu, 25 May 2006 00:51:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [-mm] oops during boot, in dock-related code
Message-ID: <20060524225141.GB4533@elf.ucw.cz>
References: <20060523083908.GA1604@elf.ucw.cz> <1148503759.28890.2.camel@whizzy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148503759.28890.2.camel@whizzy>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'll try to turn off CONFIG_ACPI_DOCK to see if it helps... yes it
> > does.
> 
> Hi Pavel,
> I must have missed part of this thread... can you give me some more
> details?  A config, log messages, or some way to reproduce?  Did you
> boot in the dock, or outside of the dock?  I tried to just boot the

Boot of thinkpad x32 outside the dock, IIRC. More details were sent
with private message.

> latest -mm with CONFIG_ACPI_DOCK set to y, and was unable to cause an
> oops.  


									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
