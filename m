Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUCBLfy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 06:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUCBLfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 06:35:54 -0500
Received: from ns.suse.de ([195.135.220.2]:3032 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261610AbUCBLfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 06:35:51 -0500
Date: Tue, 2 Mar 2004 10:10:48 +0100
From: Kurt Garloff <garloff@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040302091048.GD3356@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20040227173250.GC8834@dualathlon.random> <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com> <20040227122936.4c1be1fd.akpm@osdl.org> <20040227211548.GI8834@dualathlon.random> <162060000.1077919387@flay> <20040228023236.GL8834@dualathlon.random> <469160000.1077948622@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline
In-Reply-To: <469160000.1077948622@[10.10.2.4]>
X-Operating-System: Linux 2.6.2-0-KG i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: SUSE/Novell
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2004 at 10:10:22PM -0800, Martin J. Bligh wrote:
> Why is it 2.7GB with both 3:1 and 4:4 ... surely it can get bigger on=20
> 4:4 ???

You could use 3.7 on 4:4, but what's the point if you throw away the
mapping constantly by flushing the TLB?

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>             [Koeln, DE]
Physics:Plasma modeling <garloff@plasimo.phys.tue.nl> [TU Eindhoven, NL]
Linux: SUSE Labs (Head)        <garloff@suse.de>    [SUSE Nuernberg, DE]

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFARE+YxmLh6hyYd04RAjIeAJ4vSOriku3eSuoKUKv+i5BJS+35ZQCgrVgT
FmL8yGe9P/aGSjkj7LRmvTs=
=AWRF
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--
