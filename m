Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752091AbWCOQEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbWCOQEq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 11:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbWCOQEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 11:04:45 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:37079 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1752091AbWCOQEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 11:04:45 -0500
Date: Wed, 15 Mar 2006 11:03:16 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for	2.6.16-rc5
In-reply-to: <Pine.LNX.4.64.0603091222130.18022@g5.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tomasz Torcz <zdzichu@irc.pl>, Greg KH <gregkh@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net
Message-id: <1142438597.10394.167.camel@grayson>
Organization: Ubuntu
MIME-version: 1.0
X-Mailer: Evolution 2.5.92
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20060306223545.GA20885@kroah.com>
 <20060308222652.GR4006@stusta.de> <20060308225029.GA26117@suse.de>
 <Pine.LNX.4.64.0603081502350.32577@g5.osdl.org>
 <20060308231851.GA26666@suse.de>
 <Pine.LNX.4.64.0603081528040.32577@g5.osdl.org> <20060309184010.GA4639@irc.pl>
 <Pine.LNX.4.64.0603091137180.18022@g5.osdl.org>
 <1141935002.6072.40.camel@grayson>
 <Pine.LNX.4.64.0603091222130.18022@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 12:24 -0800, Linus Torvalds wrote:
> 
> On Thu, 9 Mar 2006, Ben Collins wrote:
> > 
> > The difference between our 2.6.15 386 and 686 kernels is actually pretty
> > huge. The 386 is M486, and UP, while our 686 kernel is M686, and SMP.
> 
> Ok, that's actually better than a _real_ M386. At least M486 has most of 
> the new instructions statically. But the SMP thing obviously makes a big 
> difference.
> 
> Can you get your tester to try "ctrl + scroll-lock" to see if it outputs 
> anything?

Here's some screen shots of the ctrl+scroll-lock the user was able to
get:

http://librarian.launchpad.net/1687295/ctl-scroll.tar.gz

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/

