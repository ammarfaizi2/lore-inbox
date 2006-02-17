Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWBQVid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWBQVid (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 16:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161153AbWBQVid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 16:38:33 -0500
Received: from mail.bmts.com ([216.183.128.202]:33989 "EHLO mail.bmts.com")
	by vger.kernel.org with ESMTP id S1751588AbWBQVic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 16:38:32 -0500
Message-ID: <43F64255.2080104@bmts.com>
Date: Fri, 17 Feb 2006 16:38:29 -0500
From: C Shore <alemc.2@bmts.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Free Hardware: Compaq RA4100 with drives, and Compaq 64-bit PCI 66
 MHz Fibre Channel Card
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=BD8DBB54
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have a compaq ra4100 RAID rack mount enclosure with 6 18.2 GB 7200 rpm
drives, a compaq 64-bit pci 66 MHz fibre channel card, and a fibre
channel cable. These work with NT, but sadly are not supported in recent
2.4 kernels (older than 2.4.19 apparently works, but I've not used that
old a kernel) or 2.6 kernel.  The driver that hp made open source is
called cpqfc, but fails to work.

I'd like to support kernel development, and I don't know anything about
driver programming in linux, or the fibre channel protocol, and while I
feel confident I could learn the necessary skills to update the driver
(or preferably split the driver up so the ra4100 could be used with
fibre channel cards other than the compaq one), I have other projects
that are higher priority for me.  Therefore, if you mail me off-list,
and can provide some verifiable bona fides, and indicate that you will
work on making this hardware work with a modern kernel, I will ship the
hardware to you for free (to most of Canada, and continental US; the
beast is *heavy* and that will be expensive enough).

I do require some sort of proof that you're not just planning on taking
the drives.  An email saying 'please send the drives, I will work on a
driver' is therefore insufficient; include references please.

I am not subscribed, so any mail on this subject should be sent directly
to me, or at least cc'd.

Thanks,

Daniel
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD9kJVeVDHer2Nu1QRAmcpAJsH0kKitm9HZxeGIS8HdgRicsVV4ACdHRaS
pKFSWHRDOeMn68f60sYUvnM=
=sBiF
-----END PGP SIGNATURE-----
