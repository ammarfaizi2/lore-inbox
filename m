Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVLUF63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVLUF63 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 00:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVLUF63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 00:58:29 -0500
Received: from h80ad2512.async.vt.edu ([128.173.37.18]:19134 "EHLO
	h80ad2512.async.vt.edu") by vger.kernel.org with ESMTP
	id S932155AbVLUF62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 00:58:28 -0500
Message-Id: <200512210557.jBL5vrOg003820@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Patrick McLean <pmclean@cs.ubishops.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Light-weight dynamically extended stacks 
In-Reply-To: Your message of "Tue, 20 Dec 2005 14:40:06 EST."
             <43A85E16.2030908@cs.ubishops.ca> 
From: Valdis.Kletnieks@vt.edu
References: <20051219001249.GD11856@waste.org> <20051219183604.GT23349@stusta.de> <20051220002759.GE3356@waste.org> <20051220164316.GG6789@stusta.de> <20051220183025.GG3356@waste.org>
            <43A85E16.2030908@cs.ubishops.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1135144665_3484P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Dec 2005 00:57:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1135144665_3484P
Content-Type: text/plain; charset=us-ascii

On Tue, 20 Dec 2005 14:40:06 EST, Patrick McLean said:
> Matt Mackall wrote:
> > 
> > This is not intended to be an automatic scheme. To use it, you must
> > actually insert code into the troublesome codepaths, which will of
> > course serve as a red flag for code review.
> > 
> 
> It might be an idea to put in a #warn to make it an even bigger red 
> flag, and to really make people fix this rather than just ignore it 
> since it works with the dynamic stacks.

Stick a 'depends on CONFIG_BROKEN' on it? ;)

--==_Exmh_1135144665_3484P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDqO7ZcC3lWbTT17ARAiatAKD1/5wmdZHKXHcBeiJaUdkc/bYLLwCgoK4u
ovrMst9YoVG1ep6XfzgoxyM=
=VgxS
-----END PGP SIGNATURE-----

--==_Exmh_1135144665_3484P--
