Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbVBQMd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbVBQMd3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 07:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVBQMd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 07:33:29 -0500
Received: from 213-229-38-66.static.adsl-line.inode.at ([213.229.38.66]:55205
	"HELO mail.falke.at") by vger.kernel.org with SMTP id S262290AbVBQMd0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 07:33:26 -0500
Message-ID: <42148EAA.10001@winischhofer.net>
Date: Thu, 17 Feb 2005 13:31:38 +0100
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050116 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: x86_64: AGP support for SiS760?
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



The SiS760 is an AMD64 chipset and AGP support works nicely in 32bit
mode. So why is AGP_SIS only configurable if !X86_64?

Thomas

- --
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net	       *** http://www.winischhofer.net
twini AT xfree86 DOT org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCFI6qzydIRAktyUcRAkIwAJsFzCUaBm2G0Q+hUsvx4yJQqC/GjACgg+yG
kYo5c2wl6/s0ZPioAVbvPUY=
=Mn0b
-----END PGP SIGNATURE-----
