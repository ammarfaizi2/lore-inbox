Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262950AbTJULQG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 07:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263054AbTJULQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 07:16:06 -0400
Received: from [212.239.226.99] ([212.239.226.99]:10370 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S262950AbTJULQD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 07:16:03 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test8] Difference between Software Suspend and Suspend-to-disk?
Date: Tue, 21 Oct 2003 13:15:54 +0200
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310211315.58585.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello all,

I'm puzzled by two options in the menuconfig which seem to do the same thing:

Software Suspend (EXPERIMENTAL)
Suspend-to-Disk Support

Do i need to have the second to actually suspend? Or does the first one by 
itself do everything I need to suspend?

Thanks.

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/lRVsUQQOfidJUwQRArkdAJ4/XEyzNle9XxPy1wkDAtTp9Hf0aQCeMOBL
qkvnb8YPymSID7AKaYtJ3Ss=
=/Nbf
-----END PGP SIGNATURE-----

