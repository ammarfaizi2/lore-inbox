Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbVHWN0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVHWN0V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 09:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVHWN0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 09:26:21 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:3699 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932166AbVHWN0U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 09:26:20 -0400
Date: Tue, 23 Aug 2005 15:26:13 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       David Hinds <dhinds@sonic.net>, "Hesse, Christian" <mail@earthworm.de>,
       linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: Re: IRQ problem with PCMCIA
Message-ID: <20050823132613.GA29062@harddisk-recovery.com>
References: <200508212043.58331.mail@earthworm.de> <20050821221739.GA18925@sonic.net> <20050821221935.GB18925@sonic.net> <1124671082.1101.0.camel@localhost.localdomain> <58cb370e050822022556595fa1@mail.gmail.com> <1124706770.7281.13.camel@localhost.localdomain> <58cb370e05082203325eb55c03@mail.gmail.com> <1124710216.7281.19.camel@localhost.localdomain> <20050823074950.GB8338@harddisk-recovery.com> <1124793118.11855.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124793118.11855.20.camel@localhost.localdomain>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 11:31:58AM +0100, Alan Cox wrote:
> On Maw, 2005-08-23 at 09:49 +0200, Erik Mouw wrote:
> > Is there any place where we can get your current patches?
> 
> Which ones - the PATA IDE ones are in 2.6.11-ac, a subset in Fedora
> (other changes in the core IDE code make forward porting stuff for
> hotplug really tricky past 2.6.11).

I know about those and have been using them on my laptop.

> The SATA ones I can certainly put up if there is interest. I don't want
> to put them somewhere too available yet because this right now is stuff
> you only want to use under controlled circumstances for development
> until both they and the core SATA layer have some improvements.

That's the one I'm interested in. Yes, I do understand it can erase all
my partitions, etc.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
