Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271977AbRIDNsY>; Tue, 4 Sep 2001 09:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271976AbRIDNsO>; Tue, 4 Sep 2001 09:48:14 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:15200 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S271975AbRIDNsC>; Tue, 4 Sep 2001 09:48:02 -0400
Date: Tue, 4 Sep 2001 14:48:14 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Michael Ben-Gershon <mybg@netvision.net.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lpr to HP laserjet stalls
Message-ID: <20010904144814.W20060@redhat.com>
In-Reply-To: <3B93E289.7F121DE9@netvision.net.il> <20010903221142.J20060@redhat.com> <3B94B4E7.701C76FA@netvision.net.il> <20010904121523.Q20060@redhat.com> <3B94B93B.2B907DCF@netvision.net.il> <20010904122751.S20060@redhat.com> <3B94D58B.180860A2@netvision.net.il> <20010904142755.V20060@redhat.com> <3B94DA02.9F6E9184@netvision.net.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="73F5niR8LUvFAf4p"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B94DA02.9F6E9184@netvision.net.il>; from mybg@netvision.net.il on Tue, Sep 04, 2001 at 04:41:22PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--73F5niR8LUvFAf4p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 04, 2001 at 04:41:22PM +0300, Michael Ben-Gershon wrote:

> Building it as a module meant I didn't have to reboot for every time
> I wanted to retest it with different parameters.

I understand.  But I'm looking at the differences between a broken
system and a working system.  It seems from what you say to be:

- CONFIG_PARPORT_PC_FIFO
- Parport built as modules

So it seems as though it's either one of these, or the combination.

Tim.
*/

--73F5niR8LUvFAf4p
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7lNueyaXy9qA00+cRAs0mAKCWbevKv4Zu0r0/vJmWKmOkiCM2FACgoKSX
aZKOovD6zTRB0yIbURPfqLk=
=Gxbc
-----END PGP SIGNATURE-----

--73F5niR8LUvFAf4p--
