Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbTJWIMi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 04:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbTJWIMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 04:12:38 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:59779 "EHLO phoebee.mail")
	by vger.kernel.org with ESMTP id S261684AbTJWIMf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 04:12:35 -0400
Date: Thu, 23 Oct 2003 10:12:30 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: John Mock <kd6pag@qsl.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Experimental patch for 'vga=ask' shows VESA modes [2.6.0-test8,
 2.4.21] [RFC]
Message-Id: <20031023101230.2c5d73e2.martin.zwickel@technotrend.de>
In-Reply-To: <E1ACPeg-0000Qx-00@penngrove.fdns.net>
References: <E1ACPeg-0000Qx-00@penngrove.fdns.net>
Organization: TechnoTrend AG
X-Mailer: Sylpheed version 0.9.4claws17 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.6.0-test4 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__23_Oct_2003_10_12_30_+0200_nn29cvpUcVW=h3mB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__23_Oct_2003_10_12_30_+0200_nn29cvpUcVW=h3mB
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2003 13:32:30 -0700
John Mock <kd6pag@qsl.net> bubbled:

> +/* Check start of Window A in VESA mode if defined.  (n.b. this might be 
> +   shifted 4 bits and/or byte-swapped, and is for color text mode only??) */
> +#ifndef CONFIG_FB
> +#define CONFIG_VGA_BIOS_CTEXT_ADDR 0xB800 */
                                             ^^ ??
-- 
MyExcuse:
Zombie processes haunting the computer

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--Signature=_Thu__23_Oct_2003_10_12_30_+0200_nn29cvpUcVW=h3mB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/l41umjLYGS7fcG0RAu7ZAKCJ/16KmTLSHk9CI0l8XgERYxvWcgCZAXCs
Z5JbCTdndHB2faSj5HjnZt4=
=WzgV
-----END PGP SIGNATURE-----

--Signature=_Thu__23_Oct_2003_10_12_30_+0200_nn29cvpUcVW=h3mB--
