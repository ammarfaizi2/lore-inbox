Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbUCLHrD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 02:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUCLHrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 02:47:03 -0500
Received: from www.npw.net ([193.96.40.17]:34267 "EHLO mail.npw.net")
	by vger.kernel.org with ESMTP id S262005AbUCLHrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 02:47:00 -0500
Message-ID: <40516AE8.2030000@npw.net>
Date: Fri, 12 Mar 2004 08:46:48 +0100
From: Philipp Baer <phbaer@npw.net>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel oops
References: <404E41A7.80707@npw.net> <20040309151106.468cf467.akpm@osdl.org>
In-Reply-To: <20040309151106.468cf467.akpm@osdl.org>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andrew Morton wrote:

|>I have a strage problem with the kernel version 2.6.3. Whensoever
|>chkrootkit is run, the following kernel oops is thrown:
|
|
| Could you try this patch?

[...]

Ok, we've patched all systems and the oops seems to have gone.
Great (and especially really fast) done, thanks!


ciao, phb

- --
Philipp Baer <phbaer@npw.net> [http://www.npw.net/]
gnupg-fingerprint: 16C7 84E8 5C5F C3D6 A8F1  A4DC E4CB A9A9 F5FA FF5D

``Only two things are infinite, the universe and human stupidity,
and I'm not sure about the former.'' -- A. Einstein

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAUWrn5MupqfX6/10RAifAAKDyz48/OV6Mlj4WOwrjOAzQO900BgCfU4+L
A+iBN6afg3cvpbrWfnaKQZw=
=rTG3
-----END PGP SIGNATURE-----
