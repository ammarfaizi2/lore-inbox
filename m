Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262518AbVCDGxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbVCDGxj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 01:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVCDGxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 01:53:39 -0500
Received: from h80ad2561.async.vt.edu ([128.173.37.97]:25604 "EHLO
	h80ad2561.async.vt.edu") by vger.kernel.org with ESMTP
	id S262518AbVCDGxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 01:53:13 -0500
Message-Id: <200503040653.j246r2T1031352@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Russell Miller <rmiller@duskglow.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: auditing subsystem 
In-Reply-To: Your message of "Thu, 03 Mar 2005 22:18:11 PST."
             <200503032218.12062.rmiller@duskglow.com> 
From: Valdis.Kletnieks@vt.edu
References: <200503032218.12062.rmiller@duskglow.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1109919181_6800P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 04 Mar 2005 01:53:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1109919181_6800P
Content-Type: text/plain; charset=us-ascii

On Thu, 03 Mar 2005 22:18:11 PST, Russell Miller said:
> I've been doing a lot of research on this, and I keep coming up with things 

> I notice there is a CONFIG_AUDIT option.  Is this what I am looking for, and 
> how do I use it?  /dev/audit seems not to work...

oooh.. a victim^Wtester ;)

CONFIG_AUDIT is indeed what you're looking for, in combination with the audit-0.6.5
userspace end just released.  Mailing list is linux-audit@redhat.com, visit
http://www.redhat.com/mailman/listinfo/linux-audit for more info....

(Currently, there's still a add-on kernel patch for stuff that's not in
the mainstream yet - but that's hopefully temporary.. ;)

--==_Exmh_1109919181_6800P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCKAXNcC3lWbTT17ARAgiWAKCNjSRoQC5/qSttqcuB8IL73zUUXwCePaH8
MLc4XF/JolkjuKUjai4ov/o=
=DVHq
-----END PGP SIGNATURE-----

--==_Exmh_1109919181_6800P--
