Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWCaXsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWCaXsM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 18:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWCaXsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 18:48:12 -0500
Received: from smtp107.rog.mail.re2.yahoo.com ([68.142.225.205]:42364 "HELO
	smtp107.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750736AbWCaXsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 18:48:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:In-Reply-To:References:Mime-Version:Content-Type:Message-Id:Cc:Content-Transfer-Encoding:From:Subject:Date:To:X-Pgp-Agent:X-Mailer;
  b=j3vrEjVPahAGz0IkSDJay3E9/iITm11TnhaFywEakbnuqgrzfTZebHXit2T6FEcS0/0bSbrAV34Bwx7lrvRsSPotj/qimirJ0wwS+FCCzk4kXo460/tkXk7xXXfgq/5y1bBD6VqY/vmZQLrokMgm2hGZiin0GF1/hTyLBAQhlO8=  ;
In-Reply-To: <BC34AAD1-595C-4E8E-A8D0-D0F1A9E93C69@rogers.com>
References: <BC34AAD1-595C-4E8E-A8D0-D0F1A9E93C69@rogers.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-45-185442290"
Message-Id: <4F7382C6-F3E9-4513-865C-695D93811761@rogers.com>
Cc: linux-kernel@vger.kernel.org, rmk+serial@arm.linux.org.uk
Content-Transfer-Encoding: 7bit
From: Georg Nikodym <georgn@rogers.com>
Subject: Re: [PATCH] 8250: yet another attempt at a serial console fix
Date: Fri, 31 Mar 2006 18:48:02 -0500
To: Georg Nikodym <georgn@rogers.com>
X-Pgp-Agent: GPGMail 1.1 (Tiger)
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-45-185442290
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed


On Mar 31, 2006, at 14:29, Georg Nikodym wrote:
>
> Since the old code worked I had trouble swallowing the backup timer  
> idea.  But the detection logic worked a charm so I lifted that and  
> offer up the attached patch for evisceration.

Please ignore my earlier patch submission.  There are at least four  
things wrong with it.

-g


--Apple-Mail-45-185442290
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (Darwin)

iD8DBQFELb+1oJNnikTddkMRAkukAKCQUNvUnkiVaetcUk5WG1dtiM+KmwCdGbPV
VrdObDZu1Y0fuNsmiJIHBzY=
=C+gW
-----END PGP SIGNATURE-----

--Apple-Mail-45-185442290--
