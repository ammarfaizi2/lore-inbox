Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVHWKET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVHWKET (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 06:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVHWKET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 06:04:19 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:11983 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751203AbVHWKES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 06:04:18 -0400
Subject: Re: IRQ problem with PCMCIA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       David Hinds <dhinds@sonic.net>, "Hesse, Christian" <mail@earthworm.de>,
       linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
In-Reply-To: <20050823074950.GB8338@harddisk-recovery.com>
References: <200508212043.58331.mail@earthworm.de>
	 <20050821221739.GA18925@sonic.net> <20050821221935.GB18925@sonic.net>
	 <1124671082.1101.0.camel@localhost.localdomain>
	 <58cb370e050822022556595fa1@mail.gmail.com>
	 <1124706770.7281.13.camel@localhost.localdomain>
	 <58cb370e05082203325eb55c03@mail.gmail.com>
	 <1124710216.7281.19.camel@localhost.localdomain>
	 <20050823074950.GB8338@harddisk-recovery.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 23 Aug 2005 11:31:58 +0100
Message-Id: <1124793118.11855.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-08-23 at 09:49 +0200, Erik Mouw wrote:
> Is there any place where we can get your current patches?

Which ones - the PATA IDE ones are in 2.6.11-ac, a subset in Fedora
(other changes in the core IDE code make forward porting stuff for
hotplug really tricky past 2.6.11).

The SATA ones I can certainly put up if there is interest. I don't want
to put them somewhere too available yet because this right now is stuff
you only want to use under controlled circumstances for development
until both they and the core SATA layer have some improvements.

Alan

