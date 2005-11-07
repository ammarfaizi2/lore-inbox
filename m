Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbVKGO6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVKGO6U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 09:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbVKGO6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 09:58:20 -0500
Received: from h80ad2541.async.vt.edu ([128.173.37.65]:33466 "EHLO
	h80ad2541.async.vt.edu") by vger.kernel.org with ESMTP
	id S932083AbVKGO6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 09:58:19 -0500
Message-Id: <200511071458.jA7Ew2no013422@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Subbu <subbu@sasken.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       subbu2k_av@yahoo.com
Subject: Re: query regarding automatic ppp (Redhat 9.0) 
In-Reply-To: Your message of "Mon, 07 Nov 2005 18:37:04 +0530."
             <Pine.GSO.4.30.0511071830030.23395-100000@sunm21.sasken.com> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.GSO.4.30.0511071830030.23395-100000@sunm21.sasken.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1131375481_7144P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 07 Nov 2005 09:58:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1131375481_7144P
Content-Type: text/plain; charset=us-ascii

On Mon, 07 Nov 2005 18:37:04 +0530, Subbu said:

>  ifcfg-ppp0 will be created in /etc/sysconfig/network-scripts when u
> create new modem connection with system settings->network->add (redhat
> 9.0) and vice-versa

1) This is not a kernel problem. It's probably not a linux-net problem either.
In fact, it's almost certainly a user error.

2) RedHat 9.0 has been unsupported for a long time - I suggest an upgrade
to either RedHat Enterprise Linux 4.1, CentOS 4.1, or Fedora Core 4, depending
on your religious beliefs.

> This message may contain confidential, proprietary or legally Privileged
> information. In case you are not the original intended Recipient of the
> message, you must not, directly or indirectly, use, Disclose, distribute,
> print, or copy any part of this message and you are requested to delete it and
> inform the sender.

Congrats.  You just prohibited anybody on the list from saying "Hey Joe, do you
know how to fix this guy's PPP problem?" and forwarding the mail.  Stupid disclaimer.

--==_Exmh_1131375481_7144P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDb2t5cC3lWbTT17ARAvCkAJ0eniPoM1Iov6KH0Rqeee2H8/zyHACg3Jmx
upkb4HlnSa+6naYYmSVXvYI=
=8rVr
-----END PGP SIGNATURE-----

--==_Exmh_1131375481_7144P--
