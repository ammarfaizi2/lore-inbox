Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTLYTmW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 14:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbTLYTmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 14:42:22 -0500
Received: from fep01.swip.net ([130.244.199.129]:8651 "EHLO fep01-svc.swip.net")
	by vger.kernel.org with ESMTP id S263462AbTLYTmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 14:42:20 -0500
Message-ID: <3FEB2BA4.3040707@free.fr>
Date: Thu, 25 Dec 2003 19:25:40 +0100
From: Jean-Luc Fontaine <jfontain@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "max..payne" <"max..payne"@freemail.hu>
Subject: Re: IDE performance drop between 2.4.23 and 2.6.0
References: <freemail.20031125173908.53283@fm3.freemail.hu>
In-Reply-To: <freemail.20031125173908.53283@fm3.freemail.hu>
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Max Payne wrote:

| IO scheduler issue? Please try repeating your tests with
| 'elevator=deadline' at boot.

Thank you for your suggestion. I tried it but it made no improvement.

Jean-Luc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/6yuhkG/MMvcT1qQRAukuAKCysq9MoIQRmLqdpwR45pV/CeTfWQCfTZ/M
uReMaFTKZu7mrzcgtsZ+Ds0=
=QQ7T
-----END PGP SIGNATURE-----

