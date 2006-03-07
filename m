Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWCGQvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWCGQvM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 11:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWCGQvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 11:51:12 -0500
Received: from mivlgu.ru ([81.18.140.87]:13225 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S1750848AbWCGQvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 11:51:11 -0500
Date: Tue, 7 Mar 2006 19:50:53 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>,
       linux kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] udf: fix uid/gid options and add uid/gid=ignore and
 forget   options
Message-Id: <20060307195053.30b2c8c6.vsu@altlinux.ru>
In-Reply-To: <440DAB7A.2040301@cfl.rr.com>
References: <4409EB37.5050308@cfl.rr.com>
	<84144f020603051122k33872fa7p1e7baebcc2b67cda@mail.gmail.com>
	<440B8C16.4050008@cfl.rr.com>
	<Pine.LNX.4.58.0603060924450.11070@sbz-30.cs.Helsinki.FI>
	<440CFCA6.5090100@cfl.rr.com>
	<Pine.LNX.4.58.0603070920360.15092@sbz-30.cs.Helsinki.FI>
	<440DAB7A.2040301@cfl.rr.com>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__7_Mar_2006_19_50_53_+0300_BprhNkO6HT83i9Lh"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__7_Mar_2006_19_50_53_+0300_BprhNkO6HT83i9Lh
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 07 Mar 2006 10:49:14 -0500 Phillip Susi wrote:

> Pekka J Enberg wrote:
> > Looks like you're using two spaces. Indentation is one tab and one tab is 
> > exactly eight characters (see Documentation/CodingStyle).
> > 
> 
> Wow!  8 spaces?  I always go with 4, 8 wastes way too much screen space. 

See Documentation/CodingStyle for reasons.

>   Is there a handy incantation to get emacs to auto indent with a hard 
> tab rather than 2 spaces like it does by default?

C-c . linux RET   (C-c . runs c-set-style; suggestions in
Documentation/CodingStyle are outdated).

--Signature=_Tue__7_Mar_2006_19_50_53_+0300_BprhNkO6HT83i9Lh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEDbnzW82GfkQfsqIRAuO9AJwIsTNe7aVSgRVEGaIW2WfWBLwHmgCeObeG
0JG3IbO4lRWstYcr35UM/j8=
=kvMO
-----END PGP SIGNATURE-----

--Signature=_Tue__7_Mar_2006_19_50_53_+0300_BprhNkO6HT83i9Lh--
