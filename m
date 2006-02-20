Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWBTKyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWBTKyY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964879AbWBTKyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:54:24 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13244 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964876AbWBTKyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:54:23 -0500
Date: Mon, 20 Feb 2006 11:54:06 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matthias Hensler <matthias@wspse.de>
Cc: Nigel Cunningham <nigel@suspend2.net>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220105406.GE16042@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060211104130.GA28282@kobayashi-maru.wspse.de> <20060218142610.GT3490@openzaurus.ucw.cz> <200602200709.17955.nigel@suspend2.net> <20060219212952.GI15311@elf.ucw.cz> <20060220094300.GC19293@kobayashi-maru.wspse.de> <20060220103616.GC16042@elf.ucw.cz> <20060220105016.GA22552@kobayashi-maru.wspse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220105016.GA22552@kobayashi-maru.wspse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 20-02-06 11:50:16, Matthias Hensler wrote:
> On Mon, Feb 20, 2006 at 11:36:16AM +0100, Pavel Machek wrote:
> > On Po 20-02-06 10:43:00, Matthias Hensler wrote:
> > > About the progress bar: this is already implemented in userspace,
> > > the kernel just forwards the progress via netlink to it. Not
> > > necessarily ugly I think.
> > 
> > Look at the code.
> 
> OK, could you point me to the ugly thinks. I see message passing between
> the userspace application and the kernel, for which I think that netlink
> is a good choice.

See my comments in "suspend2 review" thread.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
