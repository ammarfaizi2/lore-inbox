Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbTDMUf6 (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 16:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbTDMUf6 (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 16:35:58 -0400
Received: from cox.ee.ed.ac.uk ([129.215.80.253]:55014 "EHLO
	postbox.ee.ed.ac.uk") by vger.kernel.org with ESMTP id S261921AbTDMUf4 convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 16:35:56 -0400
From: Unai Garro Arrazola <Unai.Garro@ee.ed.ac.uk>
Organization: The University of Edinburgh
To: linux-kernel@vger.kernel.org
Subject: Re: i810fb problems with 2.5.66-bk10
Date: Sun, 13 Apr 2003 21:49:17 +0100
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Description: clearsigned data
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200304132149.32683.Unai.Garro@ee.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>Try my latest patch at 
>http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz


Thanks! That fixed it. Sorry for not testing before, I've been quite busy.

	Unai

- -- 
Don't get suckered in by the comments -- they can be terribly misleading.
Debug only code.
		-- Dave Storer
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+mc1QhxDfDIoZlaURAs7lAKDErpqJhTeysfNoBNpxZSwZzIxVXwCfVF5E
pDjEvHYIHGq3Vgc8xrfSQ2g=
=p4vU
-----END PGP SIGNATURE-----

