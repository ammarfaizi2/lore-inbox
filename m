Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755226AbWKMRXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226AbWKMRXi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755297AbWKMRXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:23:38 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:52181 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1755226AbWKMRXg (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:23:36 -0500
Message-Id: <200611131722.kADHMkDq007954@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Stephen Hemminger <shemminger@osdl.org>, Jan Pieter <pptp@jp.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The return of the ITeX PCI ADSL card for 2.6 kernels
In-Reply-To: Your message of "Mon, 13 Nov 2006 09:10:17 PST."
             <20061113091017.66e58a9b@freekitty>
From: Valdis.Kletnieks@vt.edu
References: <200611110116.29320.pptp@jp.dhs.org>
            <20061113091017.66e58a9b@freekitty>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1163438565_3121P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Nov 2006 12:22:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1163438565_3121P
Content-Type: text/plain; charset=us-ascii

On Mon, 13 Nov 2006 09:10:17 PST, Stephen Hemminger said:
> On Sat, 11 Nov 2006 01:16:29 +0100 Jan Pieter <pptp@jp.dhs.org> wrote:
> > ITeX stopped support for their PCI ADSL Apollo3 chipset because
> > they gone bankrupt. The latest Linux drivers for their chipset are
> > for kernel 2.4.15. They are binary-only.
> 
> Wrong list. We don't do binary drivers.... 

On the other hand, if we can track down whoever got the wreckage of the
bankrupt company, they might be persuaded to cough up enough documentation
to allow writing an open driver....

Anybody know how many Apollo3-based cards were sold?  Enough to make it
worth pursuing, or did ITeX go under because only 45 people bought the card,
and 43 of them have since disposed of the hardware?

--==_Exmh_1163438565_3121P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFWKnlcC3lWbTT17ARAqo4AJ9S9CZk/U9Te5ghZFUJ6+O5E7/OYgCcDahg
jb8a4fQko7nQnj1vpo6TZ+w=
=/9vH
-----END PGP SIGNATURE-----

--==_Exmh_1163438565_3121P--
