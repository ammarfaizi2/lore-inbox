Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbTH0CBI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 22:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263029AbTH0CBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 22:01:08 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:40721 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263014AbTH0CBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 22:01:06 -0400
Subject: Re: linux-2.4.22 released
From: =?ISO-8859-1?Q?Ram=F3n?= Rey =?UTF-8?Q?Vicente?=
	 =?UTF-8?Q?=F3=AE=A0=92?= <retes_simbad@yahoo.es>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Diego Calleja =?ISO-8859-1?Q?Garc=EDa?= <aradorlinux@yahoo.es>,
       jamagallon@able.es,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030826215544.GI7038@fs.tum.de>
References: <200308251148.h7PBmU8B027700@hera.kernel.org>
	 <20030825132358.GC14108@merlin.emma.line.org>
	 <1061818535.1175.27.camel@debian> <20030825211307.GA3346@werewolf.able.es>
	 <20030825222215.GX7038@fs.tum.de> <1061857293.15168.3.camel@debian>
	 <20030826234901.1726adec.aradorlinux@yahoo.es>
	 <20030826215544.GI7038@fs.tum.de>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1061949659.1170.26.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 27 Aug 2003 04:01:01 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El mar, 26-08-2003 a las 23:55, Adrian Bunk escribió:

> > Reasons against:
> > <write here your opinion>
> >...
> 
> - ALSA is big and there are still some bugs in ALSA; there are more
>   urgent things to be fixed in 2.4
> - it's easy to use ALSA even when it's not inside the kernel
> - within a few months 2.6.0 will be released with ALSA included -
>   together with the point above I don't see a reason why ALSA would be
>   badly needed in 2.4

According to this last reason, most of the features added to the stable
tree never havent been merged because that features will be included in
development series... :)

Why many drivers are backported from 2.5/2.6 series to 2.4? I think the
reason is because is good for stable series take a few bits from latest
kernel code for prevent obsolete and/or very old drivers.

I know this have some risks of generating more bugs in stable kernel,
but in many times, has been made backports without so much resistance ;)
-- 
Ramón Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
------------------------------------------------------------
gpg public key ID 0xBEBD71D5 # http://pgp.escomposlinux.org/

