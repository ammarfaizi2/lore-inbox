Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbTEFD6e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 23:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbTEFD6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 23:58:34 -0400
Received: from h80ad263c.async.vt.edu ([128.173.38.60]:53888 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262320AbTEFD6D (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 23:58:03 -0400
Message-Id: <200305060410.h464AMMF002501@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: sumit_uconn@lycos.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Write file in EXT2 
In-Reply-To: Your message of "Mon, 05 May 2003 23:14:46 EDT."
             <FCLJBBJOHCHPBDAA@mailcity.com> 
From: Valdis.Kletnieks@vt.edu
References: <FCLJBBJOHCHPBDAA@mailcity.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1184673444P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 06 May 2003 00:10:22 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1184673444P
Content-Type: text/plain; charset=us-ascii

On Mon, 05 May 2003 23:14:46 EDT, Sumit Narayan <sumit_uconn@lycos.com>  said:
> I would like to create a log file containing the reads and writes made on a
> disk, by adding a function in the kernel. And once this log table reaches a

Have you considered looking at the ext3 file system, which is basically ext2
with a journal?

--==_Exmh_-1184673444P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+tzWucC3lWbTT17ARAlE6AJ0QLQZ5WHo1fsV7Sa8EG3doBdNQAACgi9OS
KJo3lfMeqsVS52/OlX+6I3o=
=7YFh
-----END PGP SIGNATURE-----

--==_Exmh_-1184673444P--
