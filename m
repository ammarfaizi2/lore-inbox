Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263893AbUF2HZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUF2HZr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 03:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265520AbUF2HZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 03:25:47 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:41857 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263893AbUF2HZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 03:25:45 -0400
Date: Tue, 29 Jun 2004 09:25:50 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/19] New set of input patches
Message-ID: <20040629072550.GA1238@ucw.cz>
References: <20040628145454.9403.qmail@web81305.mail.yahoo.com> <20040628150736.GA1059@ucw.cz> <200406290201.28433.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406290201.28433.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2004 at 02:01:28AM -0500, Dmitry Torokhov wrote:
> On Monday 28 June 2004 10:07 am, Vojtech Pavlik wrote:
> > On Mon, Jun 28, 2004 at 07:54:53AM -0700, Dmitry Torokhov wrote:
> > > 
> > > Sysfs changes should be useable even without platform device changes
> > > and I would like start syncing with you. Would you take patches 2 
> > > through 10 (I will drop the legacy_position stuff)?
> >  
> > Yes.
> > 
> 
> Vojtech,
> 
> As we discussed I dropped the legacy_position sysfs attribute and moved
> patches 2 through 10 to my repository on bkbits.net. I also moved patch
> #14 because sa1111ps2, gscps2, ambakmi and pcips2 have already been 
> integrated with sysfs so linking their serio ports to their devices
> are simple one-liners not depending on anything I sent to Greg.
> 
> Please do:
> 
> 	bk pull bk://dtor.bkbits.net/input
 
Thanks!

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
