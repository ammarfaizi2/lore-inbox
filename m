Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265114AbTLFL5U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 06:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbTLFL5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 06:57:20 -0500
Received: from port-212-202-157-212.reverse.qsc.de ([212.202.157.212]:52689
	"EHLO bender.portrix.net") by vger.kernel.org with ESMTP
	id S265114AbTLFL5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 06:57:19 -0500
Message-ID: <3FD1C3E2.1050207@portrix.net>
Date: Sat, 06 Dec 2003 12:56:18 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031022 Debian/1.5-1.he-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Benecke <jens-usenet@spamfreemail.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Which optimization for different CPUs?
References: <bqs8iq$2c3$1@sea.gmane.org>
In-Reply-To: <bqs8iq$2c3$1@sea.gmane.org>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jens Benecke wrote:
| Hi,
|
| I have several servers and workstations. What optimization level in the
| kernel configuration is the maximum possible if I want to use the same
| kernel
|

Try CONFIG_M686.

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE/0cPiLqMJRclVKIYRAh9eAJ9UeGuMoFWXdOwFrqHhSYTiMIdAPQCfX+g8
N1fPw1+QETTM6Jau8VkBfcw=
=HbIJ
-----END PGP SIGNATURE-----

