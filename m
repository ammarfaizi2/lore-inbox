Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTD3CW7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 22:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTD3CW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 22:22:59 -0400
Received: from muss.CIS.McMaster.CA ([130.113.64.9]:3068 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261769AbTD3CW5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 22:22:57 -0400
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: alan@redhat.com, torvalds@transmeta.com
Subject: [PATCH] REVISED - Replace existing current->state with __set_current_state and set_current_state
Date: Tue, 29 Apr 2003 22:34:52 +0000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304292235.00130.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch applies to 2.5.68. I made the changes that Randy suggested, and 
found a couple of other errors which I also fixed. Are there any further 
errors which I missed or things to consider than I'm completely unaware of? 
Please CC me with any discussion.

http://muss.mcmaster.ca/~devenyga/linux-2.5.68-set_current_state.patch

- -- 
Building the Future,
Gabriel Devenyi
devenyga@mcmaster.ca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+rv4Q7I5UBdiZaF4RAkTXAJ4n7CQWod1K5685nLAAeJIeUhWCAQCfSloN
OVLmmBQpHPXd7r1HpdjmnNE=
=pU7z
-----END PGP SIGNATURE-----

