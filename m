Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbUAFTbM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 14:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264940AbUAFTbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 14:31:12 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:49795 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S264930AbUAFTbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 14:31:09 -0500
Date: Tue, 6 Jan 2004 19:30:51 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: linux-kernel@vger.kernel.org
Subject: psmouse_proto flag
Message-ID: <Pine.LNX.4.58.0401061929041.7109@student.dei.uc.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-DEI-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


The patch that must be reverted so people pass to the kernel psmouse_proto=imps
instead of proto=imps is not only on -mm branch: the problem still exists in
2.6.1-rc2-bk1...

Mind Booster Noori

- --
==================================================
Marcos Daniel Marado Torres AKA Mind Booster Noori
/"\               http://student.dei.uc.pt/~marado
\ /                       marado@student.dei.uc.pt
 X   ASCII Ribbon Campaign
/ \  against HTML e-mail and Micro$oft attachments
==================================================
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQE/+wzumNlq8m+oD34RAvXfAKCU58s1geoXxI72fEuDEe8U1uxuOwCgsAWI
Amxovz3gSNVyzTgylwtnzNw=
=6rfJ
-----END PGP SIGNATURE-----

