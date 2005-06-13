Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVFMBq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVFMBq0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 21:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVFMBqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 21:46:25 -0400
Received: from h80ad2736.async.vt.edu ([128.173.39.54]:37133 "EHLO
	h80ad2736.async.vt.edu") by vger.kernel.org with ESMTP
	id S261312AbVFMBqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 21:46:20 -0400
Message-Id: <200506130146.j5D1kD07005122@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Willy Tarreau <willy@w.ods.org>
Cc: subbie subbie <subbie_subbie@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: optional delay after partition detection at boot time 
In-Reply-To: Your message of "Sun, 12 Jun 2005 09:12:13 +0200."
             <20050612071213.GG28759@alpha.home.local> 
From: Valdis.Kletnieks@vt.edu
References: <20050612065050.99998.qmail@web30704.mail.mud.yahoo.com>
            <20050612071213.GG28759@alpha.home.local>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118627172_24934P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 12 Jun 2005 21:46:13 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1118627172_24934P
Content-Type: text/plain; charset=us-ascii

On Sun, 12 Jun 2005 09:12:13 +0200, Willy Tarreau said:
> On Sat, Jun 11, 2005 at 11:50:50PM -0700, subbie subbie wrote:
> > Hello,
> > 
> >  I'm sure some of you have come across this annoying
> > issue, the kernel messages scroll way too fast for a
> > human to be able to read them (let alone vgrep them).
> > 
> >  I'm proposing two features;
> > 
> >  1. a configurable (boot time, via kernel command
> > line) delay between each and every print -- kind of
> > overkill, but may be useful sometimes. 

> What's the problem with "cat /proc/partitions" or "dmesg" ?
> You seem to want to slow down *every* boot just to identify
> a partition you need to find *once*. This seems overkill.

There's been more than once that something's been borked up such that
I can't *GET* to where I can run a cat command or dmesg - and it's not
always a partition problem.

Personally, what I could go for is control-Q/S support for printk output :)

--==_Exmh_1118627172_24934P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCrOVkcC3lWbTT17ARAorYAKDJ/gBcZh2WBGEAH8xnvRs4PVRalACaA47y
UtypCo1u7zZZgsC4qx9fvds=
=deRI
-----END PGP SIGNATURE-----

--==_Exmh_1118627172_24934P--
