Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267778AbTGHWMp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267774AbTGHWMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:12:42 -0400
Received: from mail46-s.fg.online.no ([148.122.161.46]:4535 "EHLO
	mail46.fg.online.no") by vger.kernel.org with ESMTP id S267778AbTGHWMB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:12:01 -0400
From: Svein Ove Aas <svein.ove@aas.no>
To: Max Valdez <maxvalde@fis.unam.mx>, system_lists@nullzone.org,
       kernel <linux-kernel@vger.kernel.org>
Subject: Re: Forking shell bombs
Date: Wed, 9 Jul 2003 00:26:19 +0200
User-Agent: KMail/1.5.2
References: <20030708202819.GM1030@dbz.icequake.net> <5.2.1.1.2.20030708235404.02b9ec80@192.168.2.130> <1057684703.6241.3.camel@garaged.homeip.net>
In-Reply-To: <1057684703.6241.3.camel@garaged.homeip.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307090026.20319.svein.ove@aas.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

tirsdag 8. juli 2003, 19:18, skrev Max Valdez:
> I set the ulimit -u 1791
> and the box keeps running(2.4.20-gentoo-r5) , but we still need the
> problem corrected, any other user can run ther DOS and crash the box, is
> there any way to set ulimits for all users fixed ??, not by sourcein a
> bashrc or something like that ?? because the user can delete the line on
> .bashrc and thats it

/etc/security/limits.conf, on my box.

- - Svein Ove Aas
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/C0UL9OlFkai3rMARAnwsAKDEOnB8YqlzBu5TwjWFm3qVN2W8nACfZPSe
weYkPZfbHktsk4Eubm3jFAM=
=4/Xo
-----END PGP SIGNATURE-----

