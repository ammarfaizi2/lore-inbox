Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288970AbSAFP0h>; Sun, 6 Jan 2002 10:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288971AbSAFP02>; Sun, 6 Jan 2002 10:26:28 -0500
Received: from ns1.system-techniques.com ([199.33.245.254]:55720 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S288970AbSAFP0R>; Sun, 6 Jan 2002 10:26:17 -0500
Date: Sun, 6 Jan 2002 10:26:11 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Dave Jones <davej@suse.de>
cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <Pine.LNX.4.33.0201061411150.3859-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.43.0201061022420.21126-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Dave , All,

On Sun, 6 Jan 2002, Dave Jones wrote:
> On Sun, 6 Jan 2002, Mr. James W. Laferriere wrote:
> > > AFAIAC, the /proc/ide/ stuff should never have happened.
> > > It's proven that every bit of it can be done in userspace.
> > 	Then lets get rid of /proc/scsi , How about /proc/sys ...
> > 	What is the differance here ?  Maybe I am missing something ?
> And what would you replace /proc/scsi/ with ?
	And what is there to replace /proc/ide ?  I see no other facility
	in /proc to do the job .  Again am I missing something here ?

> Neither of the two you mention have viable alternatives. (yet)
	Then I submit that neither does ide .  I see nothing in your
	reply that shows me a differance between ide & scsi in /proc .

> The only time I'd consider sysctl(2) over poking /proc/sys entries
> would possibly be on an embedded system with no /proc/sys. And even then,
> I'd rather try and justify having /proc. ISTR viro proposing to split
> proc/sys out to sysctlfs at some point, which would solve this dilemma
> nicely.
	Now tho I have to agree with you here .  Tia ,  JimL

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

