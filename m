Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752820AbWKBXsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752820AbWKBXsa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 18:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbWKBXsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 18:48:30 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:3720 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1752820AbWKBXs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 18:48:29 -0500
Date: Fri, 3 Nov 2006 10:48:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Dumb question for today
Message-Id: <20061103104818.f280a003.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 2.3.0beta3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__3_Nov_2006_10_48_18_+1100_ZLo_UaMdaERZgZNE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__3_Nov_2006_10_48_18_+1100_ZLo_UaMdaERZgZNE
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Does vmalloc() zero the memory it allocates?

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__3_Nov_2006_10_48_18_+1100_ZLo_UaMdaERZgZNE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD4DBQFFSoPGFdBgD/zoJvwRAhiNAJj92NzvhCyR/dow715Q0SRhSWhCAJ9mXA4W
4Ppkg33wAFRqS9SKq+9nZg==
=uo15
-----END PGP SIGNATURE-----

--Signature=_Fri__3_Nov_2006_10_48_18_+1100_ZLo_UaMdaERZgZNE--
