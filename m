Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbTE2Oqf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 10:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbTE2Oqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 10:46:35 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:43711 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S262270AbTE2Oqe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 10:46:34 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.20-ck7 updates
Date: Fri, 30 May 2003 01:01:03 +1000
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305300101.07812.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


A few important bugfixes have come up in the last few days so I'm offerring an 
incremental bugfix patch for ck7. 

http://kernel.kolivas.org

The current updates include
fixes to my vm hacks - one corner case would make it swap out when it needed 
not to.
Update to supermount due to bug making ro disks unreadable if fs mounted rw 
and vice versa.
The elevator fix is in. Read latency2 is out.

If you do use the update, check the date versioning to tell you if you have 
the latest.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+1iCxF6dfvkL3i1gRAhV7AKCty2EELd10gNH1yPQKQt4Kwdlc8ACcCorn
iXjP6J8cddpsmHfJ0SPylt4=
=M4Dx
-----END PGP SIGNATURE-----

