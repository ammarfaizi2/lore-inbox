Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUGMVmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUGMVmx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 17:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUGMVmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 17:42:52 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:6790 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266155AbUGMVmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 17:42:35 -0400
Message-ID: <40F45746.7020001@comcast.net>
Date: Tue, 13 Jul 2004 17:42:30 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040630)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: NX: List of apps that probably break with NX
References: <40F14B75.1010802@comcast.net>
In-Reply-To: <40F14B75.1010802@comcast.net>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

OK, I missed that mozilla needs mprotect() restrictions relieved too,
i.e. it needs an executable stack to work:

/usr/lib/mozilla/mozilla-bin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA9FdFhDd4aOud5P8RAmJJAJ0euk8h7UviRo0QYHSgCwRxOlwgOgCeJZ5C
vk7tTvSMQQpO7uayXyqqhts=
=b0fV
-----END PGP SIGNATURE-----
