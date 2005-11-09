Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030486AbVKIBDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030486AbVKIBDM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 20:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030488AbVKIBDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 20:03:11 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:61911 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030486AbVKIBDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 20:03:10 -0500
Subject: Re: 3D video card recommendations
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051108220853.GA26615@merlin.emma.line.org>
References: <1131112605.14381.34.camel@localhost.localdomain>
	 <1131349343.2858.11.camel@laptopd505.fenrus.org>
	 <1131367371.14381.91.camel@localhost.localdomain>
	 <20051107152009.GA20807@shuttle.vanvergehaald.nl>
	 <1131377496.2858.21.camel@laptopd505.fenrus.org>
	 <1131384906.14381.108.camel@localhost.localdomain>
	 <20051108220853.GA26615@merlin.emma.line.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 09 Nov 2005 01:34:03 +0000
Message-Id: <1131500043.25192.125.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-08 at 23:08 +0100, Matthias Andree wrote:
> I'd rather not count the drivers that have dropped out of open source
> operating systems due to bit rot. If there is no maintainer, the
> hardware will become useless sooner or later. With Linux's rapidly
> changing "moving target" 2.6.X I'd call it sooner rather than later

If there is no maintainer and there is demand for the driver then I
guess the end users need to remember its a development model and not a
charity. The problem should then be self correcting if the docs/driver
are open

> OSS drivers are good iff there is a maintainer - IOW: to the user, the
> maintainer makes the difference, not the driver being open source.

No. If the code is open source the user can get it fixed, if it is
closed source then they are screwed because support is by vendor dictat.
If Nvidia drop TNT2 you can't pay a local consultant to fix it.

Alan

