Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281568AbRKMJoi>; Tue, 13 Nov 2001 04:44:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281567AbRKMJoV>; Tue, 13 Nov 2001 04:44:21 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:63755 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S281569AbRKMJoG>; Tue, 13 Nov 2001 04:44:06 -0500
Date: Tue, 13 Nov 2001 10:44:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: Thomas Foerster <puckwork@madz.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernel Module / Patch with implements "sshfs"
Message-ID: <20011113104405.C14574@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011112080214Z281309-17408+13481@vger.kernel.org> <20011112231545.A1081@elf.ucw.cz> <200111122347.fACNlIx19565@mailf.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111122347.fACNlIx19565@mailf.telia.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
 
> > > Mount our external Webserver from our internal Administration Server via
> > > 100MBit LAN connection.
> >
> > Install uservfs(.sf.net), then cd /overlay/#sh:user@host/.
> > 								Pavel
> 
>  
> Does all X programs support # in filename?

If they don't, they are broken.

> And how do you enter the password?

For now, only RSA autentication is supported. You can enter inside
path for ftp, but no it is not the best solution.

> (Especially if you are using it from an X program.)
> I guess you like to avoid entering it on the command line...
> 
> But I agree in principe - all kio slaves should really be uservfs slaves...

								Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
