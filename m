Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWGDPBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWGDPBz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 11:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWGDPBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 11:01:55 -0400
Received: from pool-72-66-194-43.ronkva.east.verizon.net ([72.66.194.43]:61893
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932181AbWGDPBy (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 11:01:54 -0400
Message-Id: <200607041501.k64F1qur024266@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext4 features
In-Reply-To: Your message of "Mon, 03 Jul 2006 19:00:38 EDT."
             <44A9A196.1010602@tmr.com>
From: Valdis.Kletnieks@vt.edu
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no> <44A98D5A.5030508@tmr.com> <200607032150.k63LoM4H027543@turing-police.cc.vt.edu>
            <44A9A196.1010602@tmr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152025311_4949P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 04 Jul 2006 11:01:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152025311_4949P
Content-Type: text/plain; charset=us-ascii

On Mon, 03 Jul 2006 19:00:38 EDT, Bill Davidsen said:
> Valdis.Kletnieks@vt.edu wrote:

> >There's other issues as well.  Why do people run 'tripwire' on boxes that
> >have RAID on them?
> What has RAID got to do with detecting hacking?

Actually, I've had tripwire detect more *accidental* changes due to buggy
software than I have had it detect actual hacking.  Oh, and it's good at
catching unintended config changes - I started using tripwire after I
fat-fingered a script, and the machine backed up to /dev/null instead of
/dev/rmt0.

In fact, I've never actually had tripwire detect actual hacking.

--==_Exmh_1152025311_4949P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEqoLfcC3lWbTT17ARAt43AJ9AbUtmpkevPND6P3o6l8UDsVnyywCgrwHU
GMI2vk+Txu6qOsUez8+hkPM=
=5Zdk
-----END PGP SIGNATURE-----

--==_Exmh_1152025311_4949P--
