Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751931AbWKBQX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbWKBQX5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 11:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbWKBQX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 11:23:57 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:38579 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751931AbWKBQX4 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 11:23:56 -0500
Message-Id: <200611021603.kA2G3ZoH004765@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Dave Jones <davej@redhat.com>, ray-gmail@madrabbit.org,
       "Martin J. Bligh" <mbligh@google.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: Linux 2.6.19-rc4
In-Reply-To: Your message of "Tue, 31 Oct 2006 22:39:06 GMT."
             <20061031223906.GR29920@ftp.linux.org.uk>
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061030213454.8266fcb6.akpm@osdl.org> <Pine.LNX.4.64.0610310737000.25218@g5.osdl.org> <45477668.4070801@google.com> <2c0942db0610310834i6244c0abm10c81e984565ed8a@mail.gmail.com> <20061031165133.GB23354@redhat.com> <200610312126.k9VLQtCB003616@turing-police.cc.vt.edu>
            <20061031223906.GR29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1162483415_3054P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 02 Nov 2006 11:03:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1162483415_3054P
Content-Type: text/plain; charset=us-ascii

On Tue, 31 Oct 2006 22:39:06 GMT, Al Viro said:
> It is easy, actually.

<technical explanation that boils down to "you can't just diff the messages,
you need to peek at the source" and leverages unidiff to do some of the heavy
lifting>

> default).  That's it.  About 10K of sparse C - both filter and map generator.

"10K of C code" easy is a tad different than a 4-line "diff the 2 compile logs"
easy, which is what I was sort of saying... 

--==_Exmh_1162483415_3054P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFShbXcC3lWbTT17ARAnkJAKDI/mxXSRDcvRIan860ZdV+ONdwCQCgtsPP
E5GXF0n+uLcC1r6UNlR7aBk=
=xnSo
-----END PGP SIGNATURE-----

--==_Exmh_1162483415_3054P--
