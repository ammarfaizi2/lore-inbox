Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262774AbVCEIUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbVCEIUM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 03:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbVCEIUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 03:20:12 -0500
Received: from h80ad26a8.async.vt.edu ([128.173.38.168]:23560 "EHLO
	h80ad26a8.async.vt.edu") by vger.kernel.org with ESMTP
	id S262774AbVCEIUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 03:20:06 -0500
Message-Id: <200503050819.j258Ju2R016461@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Ian Pilcher <i.pilcher@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree 
In-Reply-To: Your message of "Fri, 04 Mar 2005 23:08:55 CST."
             <d0bejc$r11$1@sea.gmane.org> 
From: Valdis.Kletnieks@vt.edu
References: <20050304222146.GA1686@kroah.com>
            <d0bejc$r11$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1110010792_5543P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 05 Mar 2005 03:19:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1110010792_5543P
Content-Type: text/plain; charset=us-ascii

On Fri, 04 Mar 2005 23:08:55 CST, Ian Pilcher said:
> Greg KH wrote:
> > Anything else anyone can think of?  Any objections to any of these?
> > I based them off of Linus's original list.
> 
> Must already be in Linus tree (i.e. 2.6.X+1)?

Not workable.  There's a high probability that we hit a bug where Linus
commits a more extensive "correct" solution, but 2.6.X.1 includes a much
simpler band-aid that's technically bogus, but stops a panic-on-boot bug
from manifesting.

--==_Exmh_1110010792_5543P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCKWuocC3lWbTT17ARAv5fAJ0V7e2XBWEogoJSa/nh4rJHfdG2zgCeKqA/
7UZr4p9R/FEtqcG+KtyMYJ4=
=4tsO
-----END PGP SIGNATURE-----

--==_Exmh_1110010792_5543P--
