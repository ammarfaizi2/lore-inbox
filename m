Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbVJDWSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbVJDWSi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 18:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbVJDWSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 18:18:38 -0400
Received: from h80ad254c.async.vt.edu ([128.173.37.76]:24493 "EHLO
	h80ad254c.async.vt.edu") by vger.kernel.org with ESMTP
	id S965012AbVJDWSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 18:18:38 -0400
Message-Id: <200510042218.j94MIUQA006057@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: umesh chandak <chandak_pict@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: error during compiling the kernel 2.6.10 on FC3 
In-Reply-To: Your message of "Tue, 04 Oct 2005 15:09:38 EDT."
             <Pine.LNX.4.61.0510041506100.30366@chaos.analogic.com> 
From: Valdis.Kletnieks@vt.edu
References: <20051004185520.9489.qmail@web35905.mail.mud.yahoo.com>
            <Pine.LNX.4.61.0510041506100.30366@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1128464310_2752P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 04 Oct 2005 18:18:30 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1128464310_2752P
Content-Type: text/plain; charset=us-ascii

On Tue, 04 Oct 2005 15:09:38 EDT, "linux-os (Dick Johnson)" said:
> On Tue, 4 Oct 2005, umesh chandak wrote:
> >    I am compiling kernel 2.6.10 on FC3 as usual

> Install new Module-Init-tools package as shown in
> ../linux-`uname -r`/Documentation/Changes...

One has to wonder how he got FC3 to boot without the new module tools,
given that it's a 2.6 kernel with everything and its pet monkey built
as modules.  Getting FC3 *installed* without them requires some rather
interesting abuse of the 'rpm' command or other similar stunts, and the
resulting system will spew tons of 'QM_MODULE' errors while booting.

His problems almost certainly lie elsewhere.

--==_Exmh_1128464310_2752P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDQv+2cC3lWbTT17ARAm26AKCaW8sK8C1TuF6lOlTF0FdOB/mtHACg1vZ+
rDRCZAZqUgHtuPaqbc49ukA=
=C4Ck
-----END PGP SIGNATURE-----

--==_Exmh_1128464310_2752P--
