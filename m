Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTLIWyN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 17:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTLIWyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 17:54:13 -0500
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:47218 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262118AbTLIWyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 17:54:09 -0500
Date: Tue, 9 Dec 2003 22:53:30 +0000
From: Ciaran McCreesh <ciaranm@gentoo.org>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Device-mapper submission for 2.4
Message-Id: <20031209225330.030716b3.ciaranm@gentoo.org>
In-Reply-To: <20031209170249.GB30286@ti19.telemetry-investments.com>
References: <20031209134551.GG472@reti>
	<Pine.LNX.4.44.0312091206490.1289-100000@logos.cnet>
	<20031209170249.GB30286@ti19.telemetry-investments.com>
X-Mailer: Sylpheed version 0.9.0claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.2FcsKKZIGcN8ld"
X-OriginalArrivalTime: 09 Dec 2003 22:54:16.0895 (UTC) FILETIME=[5F956CF0:01C3BEA7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.2FcsKKZIGcN8ld
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Dec 2003 12:02:50 -0500 "Bill Rugolsky Jr."
<brugolsky@telemetry-investments.com> wrote:
| On Tue, Dec 09, 2003 at 12:10:06PM -0200, Marcelo Tosatti wrote:
| > As far as I know, we already have the similar functionality in 2.4
| > with LVM. Device mapper provides the same functionality but in a
| > much cleaner way. Is that right?
| 
| Yes.
|  
| And migration of root-on-LVM users to 2.6 will be *greatly* helped if
| users can get LVM2/DM working on 2.4 (by upgrading
| lvm/initscripts/mkinitrd), and then move to 2.6.

Agreed. Early 2.6test kernels had serious keyboard issues on my laptop,
and the effort of switching backwards and forwards between LVM1 and 2
has put me off trying again on that box. If I could run 2.4 with LVM2
easily without having to worry about yet another manual kernel patch I'd
be a lot more inclined to do testing.

-- 
Ciaran McCreesh
Mail:    ciaranm at gentoo.org
Web:     http://dev.gentoo.org/~ciaranm



--=.2FcsKKZIGcN8ld
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1lJx96zL6DUtXhERAsr3AKDKy8LvTsQuQWEwKCbpRKyvndoKAgCfcYZj
FWB6JlDq7TgZ15aWfW7a6FI=
=KUG6
-----END PGP SIGNATURE-----

--=.2FcsKKZIGcN8ld--
