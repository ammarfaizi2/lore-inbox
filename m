Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262765AbVCJQ4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbVCJQ4m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 11:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbVCJQ4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:56:18 -0500
Received: from hc652af4b.dhcp.vt.edu ([198.82.175.75]:55562 "EHLO
	hc652af4b.dhcp.vt.edu") by vger.kernel.org with ESMTP
	id S262772AbVCJQyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 11:54:37 -0500
Message-Id: <200503100917.j2A9HmiI004026@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Tim Bird <tim.bird@am.sony.com>
Cc: Tony Luck <tony.luck@intel.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add timing information to printk messages 
In-Reply-To: Your message of "Wed, 09 Mar 2005 15:50:52 PST."
             <422F8BDC.9000005@am.sony.com> 
From: Valdis.Kletnieks@vt.edu
References: <200503092136.j29La5E26081@unix-os.sc.intel.com>
            <422F8BDC.9000005@am.sony.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1110446268_3962P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 10 Mar 2005 04:17:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1110446268_3962P
Content-Type: text/plain; charset=us-ascii

On Wed, 09 Mar 2005 15:50:52 PST, Tim Bird said:
> Tony Luck wrote:
> > Setting CONFIG_PRINTK_TIME=y I see (the "<NUL>" pieces are actually
> > each a single ASCII '\0' character):
> 
> Tony,
> 
> Can you try the patch below? (inspired by a patch from Tom Zanussi -
> gotta give credit where credit is due... :-)
> 
> This solves the problem for me but I'd like independent confirmation.

I was seeing this issue as well, and the patch clears it up here too....

--==_Exmh_1110446268_3962P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCMBC8cC3lWbTT17ARAm+1AJ9N8boapJlftvRqjDBBhNSr3YMdZACeOqb1
7V8rPFKPYc+0VtlUhaPjxEU=
=BMVW
-----END PGP SIGNATURE-----

--==_Exmh_1110446268_3962P--
