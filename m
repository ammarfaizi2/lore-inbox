Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbTIZVWd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 17:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbTIZVWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 17:22:32 -0400
Received: from [62.241.33.80] ([62.241.33.80]:42501 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261628AbTIZVWb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 17:22:31 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.23-pre5] rmap15k + 2 BK fixes
Date: Fri, 26 Sep 2003 23:21:28 +0200
User-Agent: KMail/1.5.3
Cc: Rik van Riel <riel@redhat.com>, Herbert Poetzl <herbert@13thfloor.at>
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200309262317.09687.m.c.p@wolk-project.de>
Content-Description: clearsigned data
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi there,

at the URL below you can find rmap15k ontop of 2.4.23-pre5.

Have fun. Compiles, boots, works for me [tm]

URL: http://wolk.sf.net/tmp/2.4.23-pre5-rmap15k.patch.gz
md5: 21443187d806d7368377bfad190c1c2a


P.S.: Ontop of above you can patch newest vserver patch from Herbert Poetzl 
you may find here:

URL: vserver.13thfloor.at/Experimental/patch-2.4.23-pre5-rmap15k-c17e.diff.bz2
md5: e48d64132a28d2598dd9f3b9bdad843e

ciao, Marc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: !! No Risk - No Fun !! - Try to crack this ;-)

iD8DBQE/dK3YVp3i49tEGhYRAhTCAJ4h/De+kax2z0FDhO+OXddaO/fSjACfe+KC
1+PdqiCIwvlvwm/DfflvXI4=
=IVgO
-----END PGP SIGNATURE-----

