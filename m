Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264229AbUGNUpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbUGNUpw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 16:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUGNUpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 16:45:51 -0400
Received: from gatekeeper.excelhustler.com ([68.99.114.105]:39063 "EHLO
	gatekeeper.elmer.external.excelhustler.com") by vger.kernel.org
	with ESMTP id S264229AbUGNUpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 16:45:34 -0400
Date: Wed, 14 Jul 2004 15:45:27 -0500
From: John Goerzen <jgoerzen@complete.org>
To: linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
Subject: Re: ACPI Hibernate and Suspend Strange behavior 2.6.7/-mm1
Message-ID: <20040714204527.GA31038@excelhustler.com>
References: <A6974D8E5F98D511BB910002A50A6647615FEF48@hdsmsx403.hd.intel.com> <1089054013.15671.48.camel@dhcppc4> <pan.2004.07.06.14.14.47.995955@physik.hu-berlin.de> <slrncfb55n.dkv.jgoerzen@christoph.complete.org> <20040714202700.GF22472@khan.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040714202700.GF22472@khan.acc.umu.se>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 10:27:00PM +0200, David Weinehall wrote:
> On Wed, Jul 14, 2004 at 08:16:55PM +0000, John Goerzen wrote:
> > I'm glad I'm not the only one that is suspecting that.  I just tried
> > switching my T40p from APM to ACPI.  I got suspending to RAM working in
> > ACPI, but noticed that when I got it back out of my laptop bag later, it
> > was physically warm to the touch.  It also had consumed more battery
> > power than it would have when suspended with APM.  And, if I would shine
> > a bright light on the screen, I could make out text on it.  In other
> > words, the backlight was off but it was still displaying stuff.
> 
> Does poweroff work for you?  At least my T40 has problems shutting off
> properly when using 2.6 + ACPI.  A bit annoying; I have to keep the
> powerkey pressed for a few seconds for it to turn off.

The only way I ever turn the machine off is by running the halt command,
and that is working fine for me.  I haven't tried the power key.

-- John
