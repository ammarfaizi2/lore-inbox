Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTKEQw7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 11:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTKEQw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 11:52:59 -0500
Received: from mail.eris.qinetiq.com ([128.98.1.1]:27697 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S262955AbTKEQw6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 11:52:58 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: IPVS in 2.4.23-pre9
Date: Wed, 5 Nov 2003 17:53:56 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311051653.57149.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm trying to compile 2.4.23-pre9 with the LVS/IPVS stuff, but I can't seem to 
select it from 'make xconfig' (its greyed out)

I've had a look in the .config for CONFIG_IP_VS but its not there - what do I 
need to to to compile IPVS into this kernel?

Cheers,

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/qSslBn4EFUVUIO0RAjnGAKCqM6/l0NEHyGd6yJJj7WPsIURuBgCglvz3
xwSxPwtSXPd+a+644k9nG3Y=
=c5EU
-----END PGP SIGNATURE-----

