Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314294AbSEFI7B>; Mon, 6 May 2002 04:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314295AbSEFI5n>; Mon, 6 May 2002 04:57:43 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:60978 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S314294AbSEFI5h>; Mon, 6 May 2002 04:57:37 -0400
Date: Mon, 6 May 2002 09:57:35 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add NetMos 9835 to parport_serial
Message-ID: <20020506095735.Y27042@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0205060813370.12156-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="QZtOqGcbKbKSnfK1"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QZtOqGcbKbKSnfK1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 06, 2002 at 08:17:52AM +0200, Zwane Mwaikambo wrote:

> +	/* netmos_9835 */		{ 1, { { 2, 3}, } },

Are you sure these values are correct?  They are different to the ones
in ftp://people.redhat.com/twaugh/patches/linux25/linux-netmos.patch.

That patch seems to work for some people but not for others, and I
have no idea why; until that's sorted out I'm quite reluctant to
submit any NetMos support to the mainstream kernel.  The failure mode
is a complete lock-up. :-(

Perhaps you could chase the oddity you found and see if you can figure
out what's going on?

Thanks,
Tim.
*/

--QZtOqGcbKbKSnfK1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE81kV+yaXy9qA00+cRAhj6AJ98BfTQyL99rA/lQ4vp7DzCo1aP1QCgte/V
3luzCxlfSPBHITTONhgQ+K0=
=rPX7
-----END PGP SIGNATURE-----

--QZtOqGcbKbKSnfK1--
