Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTICS3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264234AbTICS3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:29:16 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:5505 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264272AbTICS27 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:28:59 -0400
Message-Id: <200309031828.h83ISvgF008722@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scaling noise 
In-Reply-To: Your message of "Wed, 03 Sep 2003 11:07:55 PDT."
             <20030903180755.GE5769@work.bitmover.com> 
From: Valdis.Kletnieks@vt.edu
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEF@hdsmsx402.hd.intel.com> <20030903173213.GC5769@work.bitmover.com> <20030903180702.GQ4306@holomorphy.com>
            <20030903180755.GE5769@work.bitmover.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-937080232P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 03 Sep 2003 14:28:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-937080232P
Content-Type: text/plain; charset=us-ascii

On Wed, 03 Sep 2003 11:07:55 PDT, Larry McVoy <lm@bitmover.com>  said:
> On Wed, Sep 03, 2003 at 11:07:02AM -0700, William Lee Irwin III wrote:

> > You're thinking single-application again. Systems run more than one
> > thing at once.
> 
> Then explain why hyperthreading is turned off by default in Windows.

I haven't actually checked, but is it possible that the Windows HT support
suffers from the same scaling issues as the rest of the Windows innards?  To
tie  this in with what Mike Dell said - perhaps the reason he's selling mostly
1/2/4 CPU boxes is because the dominant operating system blows chunks with
more, and in the common desktop scenario enabling HT was actually slower than
leaving it off?


--==_Exmh_-937080232P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/VjLocC3lWbTT17ARAl65AJ9iFlwGVWyeh58YehtjF6hY/Zo7FQCfdiYb
FQIk7ZkgX5DrmjDG0BJDMaI=
=l7PN
-----END PGP SIGNATURE-----

--==_Exmh_-937080232P--
