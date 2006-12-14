Return-Path: <linux-kernel-owner+w=401wt.eu-S932823AbWLNSmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932823AbWLNSmZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 13:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932889AbWLNSmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 13:42:25 -0500
Received: from smtp-server.carlislefsp.com ([12.28.84.26]:46219 "EHLO
	smtp-server.carlislefsp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932823AbWLNSmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 13:42:24 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 13:42:24 EST
X-Archive-Filename: imail116612134269127632 
X-Qmail-Scanner-Mail-From: stever@carlislefsp.com via imail
X-Qmail-Scanner: 1.24st (Clear:RC:1(10.10.3.184):. Processed in 0.032264 secs Process 27632)
Message-ID: <45819939.3030701@carlislefsp.com>
Date: Thu, 14 Dec 2006 12:34:33 -0600
From: Steve Roemen <stever@carlislefsp.com>
Reply-To: stever@carlislefsp.com
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: iss_storagedev@hp.com, mike.miller@hp.com
Subject: 2.6.19-git20 cciss: cmd f7b00000 timedout
X-Enigmail-Version: 0.94.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

All,
    I tried out the 2.6.19-git20 kernel on one of my machines (HP
DL380 G3) that has the on board 5i controller (disabled),
2 smart array 642 controllers.

I get the error (cciss: cmd f7b00000 timedout) with Buffer I/O error
on device cciss/c (all cards, and disks) logical block 0, 1, 2, etc



Steve Roemen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgZk5cA4cgQlZoQ8RAgUYAKCCfn+SGLPy+/Ng/7Lyh/m/AigiJwCcDEO3
vNUZctiG+TxZ2oPcOVVigRY=
=6WKY
-----END PGP SIGNATURE-----

