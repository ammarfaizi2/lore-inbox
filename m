Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbTIWTyi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbTIWTyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:54:37 -0400
Received: from starcraft.mweb.co.za ([196.2.45.78]:10664 "EHLO
	starcraft.mweb.co.za") by vger.kernel.org with ESMTP
	id S261293AbTIWTyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:54:36 -0400
Date: Tue, 23 Sep 2003 21:54:59 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: german aracil boned <german@tecnoxarxa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: iptables kernel
Message-Id: <20030923215459.2ba0994e.bonganilinux@mweb.co.za>
In-Reply-To: <3F7059AA.2060504@tecnoxarxa.com>
References: <3F7059AA.2060504@tecnoxarxa.com>
X-Mailer: Sylpheed version 0.9.5claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="Multipart_Tue__23_Sep_2003_21_54_59_+0200_=..zHYSHKPwX'vzO"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Multipart_Tue__23_Sep_2003_21_54_59_+0200_=..zHYSHKPwX'vzO
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2003 16:33:14 +0200
german aracil boned <german@tecnoxarxa.com> wrote:

> 
> 
> I have problems with iptables and openmosix system. The kernel is halted
>   when I write DENY by default in INPUT keys. This machine boot from net
> and have root in other coputer..
> 
> What is the solution ? ( and problem:( )
> 
> My kernel 2.4.20 - with openmosix patch
> (same problem if don't work with openmosix patch)
> 
> Can this kernel work with DENY politic boot first from net ?
> 
> thanks

Doesn't that block replies from the server you are booting from? Try accepting packets were the state is ESTABLISHED 

--Multipart_Tue__23_Sep_2003_21_54_59_+0200_=..zHYSHKPwX'vzO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/cKUc+pvEqv8+FEMRAh40AJ9zpbeZUug+fUk4qyVl+3vhPnSbxgCfUAo8
ZrACYUGOEyVHQj5RDZU+Wr8=
=vGTL
-----END PGP SIGNATURE-----

--Multipart_Tue__23_Sep_2003_21_54_59_+0200_=..zHYSHKPwX'vzO--
