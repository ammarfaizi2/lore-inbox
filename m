Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTLCMU2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 07:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264504AbTLCMU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 07:20:28 -0500
Received: from chico.rediris.es ([130.206.1.3]:60159 "EHLO chico.rediris.es")
	by vger.kernel.org with ESMTP id S261539AbTLCMU0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 07:20:26 -0500
From: David =?iso-8859-15?q?Mart=EDnez=20Moreno?= <ender@debian.org>
Organization: Debian
To: Oleg Drokin <green@linuxhacker.ru>, linux-kernel@vger.kernel.org
Subject: Re: Current 2.4.23-rc* kernels has broken ACPI (at least for me).
Date: Wed, 3 Dec 2003 13:20:18 +0100
User-Agent: KMail/1.5.4
References: <200311281615.00715.ender@debian.org> <200311281940.hASJeVSD008668@car.linuxhacker.ru>
In-Reply-To: <200311281940.hASJeVSD008668@car.linuxhacker.ru>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200312031320.18882.ender@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

El Viernes, 28 de Noviembre de 2003 20:40, Oleg Drokin escribió:
> Hello!
>
> David Mart?nez Moreno <ender@debian.org> wrote:
> DMnM> PCI: PCI BIOS revision 2.10 entry at 0xfd9ce, last bus=1
> DMnM> PCI: Using configuration type 1
> DMnM> Unable to handle kernel NULL pointer dereference at virtual address
> 000000ae
>
> This very same oops was cured for me by
> cp .config .. ; make distclean ; mv ../.config . ; make oldconfig ;
> make bzImage modules

	Although I would swore that I tried that...it worked.

	Sorry for making you lose time. :-( Thank you very much.


		Ender.
- -- 
Non. Je suis la belette de personne.
		-- Amélie (Le fabuleux destin d'Amélie Poulain)
- --
Servicios de red - Network services
Centro de Comunicaciones CSIC/RedIRIS
Spanish Academic Network for Research and Development
Madrid (Spain)
Tlf (+34) 91.585.49.05
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/zdUCWs/EhA1iABsRAlb7AKDkmtUIdS/JHWzpv9by4ZBH3ujZxQCgt10y
2zrIhe4sdTqRS8ydlFCbPvk=
=TDG5
-----END PGP SIGNATURE-----

