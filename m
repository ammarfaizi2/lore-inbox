Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261687AbSI0StP>; Fri, 27 Sep 2002 14:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262564AbSI0StP>; Fri, 27 Sep 2002 14:49:15 -0400
Received: from hc652a8bf.dhcp.vt.edu ([198.82.168.191]:27008 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S261687AbSI0StO>; Fri, 27 Sep 2002 14:49:14 -0400
Message-Id: <200209271854.g8RIsPe6002510@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [RFC] LSM changes for 2.5.38 
In-Reply-To: Your message of "Fri, 27 Sep 2002 19:19:43 BST."
             <20020927191943.A2204@infradead.org> 
From: Valdis.Kletnieks@vt.edu
X-Url: http://black-ice.cc.vt.edu/~valdis/
X-Face-Viewer: See ftp://cs.indiana.edu/pub/faces/index.html to decode picture 
X-Face: 34C9$Ewd2zeX+\!i1BA\j{ex+$/V'JBG#;3_noWWYPa"|,I#`R"{n@w>#:{)FXyiAS7(8t(
 ^*w5O*!8O9YTe[r{e%7(yVRb|qxsRYw`7J!`AM}m_SHaj}f8eb@d^L>BrX7iO[<!v4-0bVIpaxF#-)
 %9#a9h6JXI|T|8o6t\V?kGl]Q!1V]GtNliUtz:3},0"hkPeBuu%E,j(:\iOX-P,t7lRR#
References: <20020927003210.A2476@sgi.com> <Pine.GSO.4.33.0209270743170.22771-100000@raven> <20020927175510.B32207@infradead.org> <200209271809.g8RI92e6002126@turing-police.cc.vt.edu>
            <20020927191943.A2204@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1139728314P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 27 Sep 2002 14:54:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1139728314P
Content-Type: text/plain; charset=us-ascii

On Fri, 27 Sep 2002 19:19:43 BST, Christoph Hellwig said:

> So I have to download the driver source and change the parameter
> to i_m_to_fscking_intelligent_for_the_nsa_eth=0?

By the same token, at that point you can download the kernel source and
build it without LSM.  What I showed was a way to bypass the iptables
rules set up *WITHOUT REPLACING A MODULE* (which might be detected by
tripwire, or totally refused because the LSM rejects any writes in /lib/modules).



-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-1139728314P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE9lKlhcC3lWbTT17ARAn+xAKC0nsRCYvWyjawIUjt8tvuWZlV84wCgkKBg
MhrNJKQVubqNIY1PaboGQe0=
=RBHP
-----END PGP SIGNATURE-----

--==_Exmh_-1139728314P--
