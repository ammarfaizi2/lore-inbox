Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbTAaRfz>; Fri, 31 Jan 2003 12:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261733AbTAaRfz>; Fri, 31 Jan 2003 12:35:55 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:63495 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261724AbTAaRfy>; Fri, 31 Jan 2003 12:35:54 -0500
Date: Fri, 31 Jan 2003 18:45:19 +0100
From: Pavel Machek <pavel@ucw.cz>
To: =?iso-8859-2?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Pavel Machek <pavel@ucw.cz>, Xavier Bestel <xavier.bestel@free.fr>,
       Raphael Schmid <Raphael_Schmid@CUBUS.COM>,
       "'John Bradford'" <john@grabjohn.com>, rob@r-morris.co.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
Message-ID: <20030131174519.GA26929@atrey.karlin.mff.cuni.cz>
References: <398E93A81CC5D311901600A0C9F2928946937F@cubuss2> <1043764502.24813.16.camel@bip.localdomain.fake> <20030130072521.GA559@zaurus> <20030131174036.GA9694@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030131174036.GA9694@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, with right scripts you can probably boot
> > faster than do resume (and you can certainly
> > shutdown faster than suspend). OTOH, if you
> > turn off ide-scsi in 2.5.59, swsusp should just
> > work.
> 
> But it takes quite a while to open all those editor windows again, let
> alone remembering, where you were when you closed them. This is the
> real benefit I see in software suspend.

Hey, I'm developing swsusp, no need to tell *me* its usefull. Primary
application here will be to be able to do long-running computation
(lingvistic experiments) and *still* sleep at night ;-).

								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
