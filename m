Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264955AbUEVKrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264955AbUEVKrm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 06:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264957AbUEVKrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 06:47:42 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:43970 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S264955AbUEVKrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 06:47:37 -0400
Message-ID: <40AF2FC7.4080509@g-house.de>
Date: Sat, 22 May 2004 12:47:35 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at fs/buffer.c:1270! [TAINTED]
References: <1085160887.7956.4.camel@bluerhyme.real3>
In-Reply-To: <1085160887.7956.4.camel@bluerhyme.real3>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

FabF schrieb:
| Hi,
| 	Wouldn't be interesting in that oops case to try adding joliet and
| remove autofs4 ?

do you mean me adding joliet support to the kernel and "rmmod"ing
autofs4 oder Andrew's patch?

well, joliet-support for the isofs module is selected, and autofs4 just
mounts the cd.....

Christian.

- --
BOFH excuse #223:

The lines are all busy (busied out, that is -- why let them in to begin
with?).
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAry/H+A7rjkF8z0wRAkGHAJ9DuJSQft73RJ9Pe/nX4YruVt7ruwCfZuBh
Qwt6Gd2voF9vk3k1sHKc4rY=
=7cm/
-----END PGP SIGNATURE-----
