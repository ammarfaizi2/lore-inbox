Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265178AbTFYX23 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 19:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265208AbTFYX1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 19:27:00 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:20953 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S265178AbTFYXZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 19:25:24 -0400
Date: Wed, 25 Jun 2003 19:39:34 -0400
From: Scott McDermott <vaxerdec@frontiernet.net>
To: linux-kernel@vger.kernel.org
Cc: dsen@homemail.com
Subject: Re: ide-scsi on 2.4.21 (on IBM Thinkpad T30)
Message-ID: <20030625193934.N9583@newbox.localdomain>
References: <3EF753EC.9080807@homemail.com> <3EFA2B83.3090305@homemail.com> <20030625193829.M9583@newbox.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030625193829.M9583@newbox.localdomain>; from vaxerdec@frontiernet.net on Wed, Jun 25, 2003 at 07:38:29PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

whoops forgot to add you to CC list as per your request

To linux-kernel@vger.kernel.org on Wed 25/06 19:38 -0400:
> D. Sen on Thu 26/06 09:08 +1000:
> > > > Kernel 2.4.21 causes hangs and/or ooops during boot up
> > > > if I have a "probeall scsi_hostadapter ide-scsi" in my
> > > > /etc/modules.conf. If I take out that line and
> > > > manually load the module after the laptop has booted,
> > > > everything is fine.
> > > 
> > > I probably have the same CD-RW that you do (in the T30)
> > > and I just use hdc=ide-scsi on kernel command line, no
> > > need for manually loading. Works fine but don't try
> > > burning with magicdev running :)
> > 
> > Do you have ide-scsi built as a module though?
> 
> Yes.  It works fine, I just tried with cdrdao using
> generic-mmc driver.  I have nothing at all in modules.conf
> related to cd, ide, or scsi.
