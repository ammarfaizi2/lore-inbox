Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAaDCX>; Tue, 30 Jan 2001 22:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbRAaDCN>; Tue, 30 Jan 2001 22:02:13 -0500
Received: from ns.snowman.net ([63.80.4.34]:48394 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S129431AbRAaDB6>;
	Tue, 30 Jan 2001 22:01:58 -0500
Date: Tue, 30 Jan 2001 22:01:48 -0500
From: Stephen Frost <sfrost@snowman.net>
To: David Ford <david@linux.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x and SMP fails to compile (`current' undefined)
Message-ID: <20010130220148.Y26953@ns>
Mail-Followup-To: David Ford <david@linux.com>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3A777E1A.8F124207@linux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AVGAi4VzQ7CM9FTC"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A777E1A.8F124207@linux.com>; from david@linux.com on Tue, Jan 30, 2001 at 06:53:14PM -0800
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.2.16 (i686)
X-Uptime: 10:01pm  up 167 days,  1:45,  9 users,  load average: 2.00, 2.00, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AVGAi4VzQ7CM9FTC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* David Ford (david@linux.com) wrote:
> A person just brought up a problem in #kernelnewbies, building an SMP
> kernel doesn't work very well, current is undefined.  I don't have more
> time to debug it but I'll strip the config and put it up at
> http://stuph.org/smp-config

	They're trying to compile SMP for Athlon/K7 (CONFIG_MK7=y).

		Stephen

--AVGAi4VzQ7CM9FTC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6d4AcrzgMPqB3kigRAmaMAJ4vWGoJ+s0dPF/6E2U5rwCMdzTt2gCZARVP
gK72wC3fr1KJ/2RwCwaSvVM=
=wJuU
-----END PGP SIGNATURE-----

--AVGAi4VzQ7CM9FTC--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
