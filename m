Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264735AbUEKN7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264735AbUEKN7J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 09:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264738AbUEKN7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 09:59:09 -0400
Received: from pD9E09B92.dip.t-dialin.net ([217.224.155.146]:26760 "EHLO
	router.zodiac.dnsalias.org") by vger.kernel.org with ESMTP
	id S264735AbUEKN7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 09:59:05 -0400
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: maneesh@in.ibm.com
Subject: Re: kernel BUG at include/linux/dcache.h:277!
Date: Tue, 11 May 2004 15:58:50 +0200
User-Agent: KMail/1.6.2
References: <200405110037.13819@zodiac.zodiac.dnsalias.org> <20041006105039.GC2004@in.ibm.com>
In-Reply-To: <20041006105039.GC2004@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200405111558.54746@zodiac.zodiac.dnsalias.org>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Mittwoch, 6. Oktober 2004 12:50 schrieb Maneesh Soni:
> It looks like parent kobject is gone before the child can be deleted. Do
> you see similar problem in 2.6.6 also?

Did not try, had no bluetooth device before.
If you like I'll try that today.

regads
Alex

- --
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAoNwd/aHb+2190pERAoaqAJsFKGghgsM9bdP/kJHUmqhM4HGnMgCglYYr
xlAocOqUP/gy60nCIumpDgE=
=mu4U
-----END PGP SIGNATURE-----
