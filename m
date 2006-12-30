Return-Path: <linux-kernel-owner+w=401wt.eu-S1030285AbWL3Hb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWL3Hb6 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 02:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbWL3Hb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 02:31:58 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:44666 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030285AbWL3Hb5 (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 02:31:57 -0500
Message-Id: <200612300731.kBU7VlqN024831@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Karel Zak <kzak@redhat.com>
Cc: Theodore Tso <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org, Henne Vogelsang <hvogel@suse.de>,
       Olaf Hering <olh@suse.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: util-linux: orphan
In-Reply-To: Your message of "Wed, 27 Dec 2006 23:12:51 +0100."
             <20061227221251.GF17785@petra.dvoda.cz>
From: Valdis.Kletnieks@vt.edu
References: <20061109224157.GH4324@petra.dvoda.cz> <200612270346.10699.arnd@arndb.de> <20061227181510.GB17785@petra.dvoda.cz> <200612271939.48125.arnd@arndb.de> <20061227191824.GC17785@petra.dvoda.cz> <20061227204212.GA21393@thunk.org>
            <20061227221251.GF17785@petra.dvoda.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1167463907_11654P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 30 Dec 2006 02:31:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1167463907_11654P
Content-Type: text/plain; charset=us-ascii

On Wed, 27 Dec 2006 23:12:51 +0100, Karel Zak said:
>  For example for my laptop is it true that "life is too short to
>  enable SELinux", but it's probably not true for servers in the bank where
>  I have money. (I hope so:-)

On the other hand, the case can be made that your laptop needs SELinux *more*
than the bank servers - because the bank servers are (presumably) heavily
firewalled and stripped down software-wise, and otherwise hardened.  But
your laptop is exactly one Firefox buffer overflow from being completely pwned...

--==_Exmh_1167463907_11654P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFlhXjcC3lWbTT17ARAhjQAJ9lWiCDwYNBdreJ3GrvcfLblvkDeQCdGH1E
QEzqBT19diFhANjBfud7Mcg=
=ZFFN
-----END PGP SIGNATURE-----

--==_Exmh_1167463907_11654P--
