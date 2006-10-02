Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965204AbWJBSXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965204AbWJBSXI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 14:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965206AbWJBSXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 14:23:08 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:3233 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S965204AbWJBSXG (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 14:23:06 -0400
Message-Id: <200610021822.k92IMo44008167@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Martin J. Bligh" <mbligh@mbligh.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Spam, bogofilter, etc
In-Reply-To: Your message of "Mon, 02 Oct 2006 11:02:36 PDT."
             <Pine.LNX.4.64.0610021050350.3952@g5.osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <1159539793.7086.91.camel@mindpipe> <20061002100302.GS16047@mea-ext.zmailer.org> <1159802486.4067.140.camel@mindpipe> <45212F39.5000307@mbligh.org> <Pine.LNX.4.64.0610020933020.3952@g5.osdl.org> <1159811392.8907.36.camel@localhost.localdomain>
            <Pine.LNX.4.64.0610021050350.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159813369_5418P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Oct 2006 14:22:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159813369_5418P
Content-Type: text/plain; charset=us-ascii

On Mon, 02 Oct 2006 11:02:36 PDT, Linus Torvalds said:

> > MX checking is as broken or more broken than bayes.
> 
> I have to say, OSDL has been doing MX checking, and it's effective as 
> hell. Most importantly, when it _does_ break, it's not because some 
> "content" is considered inappropriate, it's because some ISP does 
> something technically wrong.

How did OSDL's MX checking deal with split in/out configurations like ours,
where our MX points at a load-balanced farm of Mirapoint front end appliances
with 1 IP address, but our main off-campus *outbound* comes from a different
address?

--==_Exmh_1159813369_5418P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFIVj5cC3lWbTT17ARAsWuAKCMpjeT8dMoRs1VuuEEq1htqDrt7wCfTGg2
uIrvX3p7SYvurExZzC8T22w=
=btxU
-----END PGP SIGNATURE-----

--==_Exmh_1159813369_5418P--
