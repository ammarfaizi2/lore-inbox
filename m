Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131499AbQKTNVY>; Mon, 20 Nov 2000 08:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131623AbQKTNVO>; Mon, 20 Nov 2000 08:21:14 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:3430 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131499AbQKTNVD>; Mon, 20 Nov 2000 08:21:03 -0500
Date: Mon, 20 Nov 2000 12:51:00 +0000
From: Tim Waugh <twaugh@redhat.com>
To: John Cavan <johncavan@home.com>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (new for ppa and imm) Re: [PATCH] Re: Patch to fix lockup on ppa insert
Message-ID: <20001120125100.R20970@redhat.com>
In-Reply-To: <3A13D4BA.AD4A580B@home.com> <3A13D8D6.8C12E31A@home.com> <20001116162027.C597@suse.de> <3A149D00.9D38FA24@home.com> <20001117102411.S6735@redhat.com> <3A16FE50.2B6BA09B@home.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="7kD9y3RnPUgTZee0"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A16FE50.2B6BA09B@home.com>; from johncavan@home.com on Sat, Nov 18, 2000 at 05:10:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7kD9y3RnPUgTZee0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 18, 2000 at 05:10:24PM -0500, John Cavan wrote:

> it is. The new scsi error stuff does mention that drivers must
> spinunlock/spinlock if it enables interrupts.

Okay, I guess it is safe then.

Tim.
*/

--7kD9y3RnPUgTZee0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6GR4zONXnILZ4yVIRAl2XAJ99AX+zoDjh0epdyCB7V6Cp8E5X7ACfVoBn
93AJ1GgYyMTPo7u77QJ3b1U=
=b4aq
-----END PGP SIGNATURE-----

--7kD9y3RnPUgTZee0--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
