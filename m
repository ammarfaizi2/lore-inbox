Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264166AbUDGVAl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 17:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264170AbUDGVAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 17:00:41 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:48001 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S264166AbUDGVAk (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 17:00:40 -0400
Message-Id: <200404072100.i37L0QGe005005@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andy Isaacson <adi@hexapodia.org>
Cc: Andrew Morton <akpm@osdl.org>, bug-coreutils@gnu.org,
       linux-kernel@vger.kernel.org
Subject: Re: dd PATCH: add conv=direct 
In-Reply-To: Your message of "Wed, 07 Apr 2004 15:43:41 CDT."
             <20040407204341.GF2814@hexapodia.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040406220358.GE4828@hexapodia.org> <20040406173326.0fbb9d7a.akpm@osdl.org> <20040407173116.GB2814@hexapodia.org> <20040407111841.78ae0021.akpm@osdl.org> <20040407192432.GD2814@hexapodia.org> <20040407123455.0de9ffa9.akpm@osdl.org> <20040407194727.GE2814@hexapodia.org> <20040407130308.7c7ec8dc.akpm@osdl.org>
            <20040407204341.GF2814@hexapodia.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1448953862P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 07 Apr 2004 17:00:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1448953862P
Content-Type: text/plain; charset=us-ascii

On Wed, 07 Apr 2004 15:43:41 CDT, Andy Isaacson said:
> On Wed, Apr 07, 2004 at 01:03:08PM -0700, Andrew Morton wrote:
> > If you want a block scrubber then write a block scrubber.
> They exist.  They're a pain in the ass to find when you need one.  dd is

And finding a block scrubber that actually works *properly* is even more of a
challenge.  I've seen more than a few that do stupid things like truncating the
file and then writing the appropriate number of bytes....


--==_Exmh_-1448953862P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAdGvqcC3lWbTT17ARAt7TAJ9tKIEw1xA8m4+Emteu1C7mbz3XVgCeNHLz
PUHI9AWvkUYijQZ5N0IFKBg=
=qF7w
-----END PGP SIGNATURE-----

--==_Exmh_-1448953862P--
