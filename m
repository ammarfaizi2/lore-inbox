Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUJATCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUJATCP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 15:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUJATCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 15:02:15 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:45752 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266137AbUJATCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 15:02:13 -0400
Message-Id: <200410011902.i91J27qO028646@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: cranium2003 <cranium2003@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.linux.org
Subject: Re: Plzzz help me 
In-Reply-To: Your message of "Thu, 30 Sep 2004 19:41:36 PDT."
             <20041001024136.96889.qmail@web41402.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20041001024136.96889.qmail@web41402.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2044784972P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 01 Oct 2004 15:02:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2044784972P
Content-Type: text/plain; charset=us-ascii

On Thu, 30 Sep 2004 19:41:36 PDT, cranium2003 said:
> Hello,
>  I want to know is there any way in linux kernel by
> which i can come to know that the outgoing packet is
> having destination address is of host not of router?
> I want to send different data to host/router depending
> on dest. address. 

What if the router is a host as well? This is quite possible
if the router is a unix/linux box with more than one network
interface.

What problem are you trying to solve by sending different data?

--==_Exmh_2044784972P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBXamucC3lWbTT17ARAldLAJ4nHC00WiiJ2IZ0GwqCmSBr/GOuywCcDYj9
SXHoxDleHpbdjqHTwmbt7Tc=
=Gruy
-----END PGP SIGNATURE-----

--==_Exmh_2044784972P--
