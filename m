Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbUADVCb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 16:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbUADVCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 16:02:31 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:6537 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263661AbUADVC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 16:02:29 -0500
Message-ID: <3FF87F41.1090007@eglifamily.dnsalias.net>
Date: Sun, 04 Jan 2004 14:01:53 -0700
From: Dan Egli <dan@eglifamily.dnsalias.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Armin <Zoup@zoup.org>
CC: linux-kernel@vger.kernel.org
References: <200401041241.26368.Zoup@zoup.org>
In-Reply-To: <200401041241.26368.Zoup@zoup.org>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Subject: Re: Crazy Mouse !
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dan@eglifamily.dnsalias.net
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Armin wrote:
| Hi list ,
| im using 2.6.1-rc1 , i have an ps2 mouse ( in fact , its touch pad !
but iv
| got this problem with external mouse too ) , when my box is under
heavy ( or
| normal ) load , mouse start to be crazy , dancing all around the
screen and
| click every where ... how can i fix it ?
|

Did you try restarting gpm? That happens to me whenever I swap from one
machine to another on the KVM switch. When I go back my mouse is
abslultely insane. Does everything EXCEPT what I said to do. 99 of 100
times killing and restarting gpm fixes it.

- --- Dan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQE/+H9BtwT22Jak4/4RAuXuAJ9935AmYjUkY/KUj8kgmrPLcbWvyACdG19K
MKqhSY/YkVEiYwE7ZATRsiU=
=PI1Q
-----END PGP SIGNATURE-----

