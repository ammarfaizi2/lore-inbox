Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751801AbWCECE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbWCECE6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 21:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbWCECE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 21:04:58 -0500
Received: from smtpout10.uol.com.br ([200.221.4.201]:24296 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S1751801AbWCECE5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 21:04:57 -0500
Date: Sat, 4 Mar 2006 23:04:43 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: "Marco d'Itri" <md@Linux.IT>
Cc: debian-powerpc@lists.debian.org, debian-boot@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: Debian Installer - boot floppies
Message-ID: <20060305020443.GA514@ime.usp.br>
Mail-Followup-To: Marco d'Itri <md@Linux.IT>,
	debian-powerpc@lists.debian.org, debian-boot@lists.debian.org,
	linux-kernel@vger.kernel.org
References: <44007A0F.7080205@arach.net.au> <20060226135510.GA26166@localhost.localdomain> <20060226160034.GA16992@pants.nu> <200603032204.50904.aragorn@tiscali.nl> <20060303223035.GB25184@pants.nu> <20060304070854.GA31566@localhost.localdomain> <dudd93$frt$1@wonderland.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dudd93$frt$1@wonderland.linux.it>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 05 2006, Marco d'Itri wrote:
> sven.luther@wanadoo.fr wrote:
> >I guess we are using udev, but with a devfs-like naming scheme on
> >top, right ?  I strongly believe that swim3.ko is not hotplug
> >friendly, or that udev has some trouble with builtin modules, but i
> >would go for the first case.
>
> udev handles built-in drivers without problems, but it can create
> devices only for drivers which use the 2.6 driver core.

Nice to know that.

> If they have not been fixed yet then they are unmaintained or very
> close to this, and it's about time they are fixed or support is
> dropped.

It would be a real pitty to see swim3 dropped from the kernel. Speaking
as a mere user here, that's one of the main ways that I get information
into and from the old PowerMac 9500 that I have here.

And, I don't know if this has been reported earlier, but using mtools
(say, mcopy and friends) makes the drive become unusable (I don't
remember the messages literally here, because I'm not at the front of
the computer, but I can serve as a guinea pig if needed---despite my
lack of free time).


Thanks, Rogério Brito.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
