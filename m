Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVBUCET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVBUCET (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 21:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVBUCET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 21:04:19 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:61644 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S261411AbVBUCEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 21:04:14 -0500
Date: Mon, 21 Feb 2005 01:59:00 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Michal Januszewski <spock@gentoo.org>
cc: Pavel Machek <pavel@suse.cz>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bootsplash for 2.6.11-rc4
In-Reply-To: <20050220132600.GA19700@spock.one.pl>
Message-ID: <Pine.LNX.4.61.0502210152240.6600@student.dei.uc.pt>
References: <20050218165254.GA1359@elf.ucw.cz> <20050219011433.GA5954@spock.one.pl>
 <20050219230326.GB13135@kroah.com> <20050219232519.GC1372@elf.ucw.cz>
 <20050220132600.GA19700@spock.one.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UC-FCT-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-FCT-DEI-MailScanner: Found to be clean
X-MailScanner-From: marado@student.dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 20 Feb 2005, Michal Januszewski wrote:

> On Sun, Feb 20, 2005 at 12:25:19AM +0100, Pavel Machek wrote:
>
>> How many distros do use some variant of bootsplash? SuSE does, from
>> above url I guess gentoo does, too... Does RedHat do something
>> similar? [Or do they just set log-level to very high giving them clean
>> look?] What about Debian?
>
> As far as I know: SuSE uses bootsplash, Gentoo and PLD use fbsplash,
> RedHat uses rhgb (100% userspace solution, based on xvesa, doesn't
> provide graphical backgrounds on vt's - for that a kernel patch like
> bootsplash or fbsplash is necessary). I don't know about Debian - they
> probably have some (possibly unofficial) support for both bootsplash
> and fbsplash.

Indeed, there is bootsplash and fbsplash for Debian, but only unofficial
packages.

Marcos Marado

- -- 
/* *************************************************************** */
    Marcos Daniel Marado Torres	     AKA	Mind Booster Noori
    http://student.dei.uc.pt/~marado   -	  marado@student.dei.uc.pt
    () Join the ASCII ribbon campaign against html email, Microsoft
    /\ attachments and Software patents.   They endanger the World.
    Sign a petition against patents:  http://petition.eurolinux.org
/* *************************************************************** */
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQFCGUFmmNlq8m+oD34RAtbqAJ43WanT3YNwRy8bkUIbrIqCl8u1mgCggy6R
4jZqOJQoO3vCeBe/fE/WUhk=
=CFlt
-----END PGP SIGNATURE-----

