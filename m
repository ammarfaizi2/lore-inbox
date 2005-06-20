Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVFTKNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVFTKNl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 06:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVFTKNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 06:13:41 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:37031 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S261300AbVFTKMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 06:12:31 -0400
Message-ID: <42B697B4.8060109@stesmi.com>
Date: Mon, 20 Jun 2005 12:17:24 +0200
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org,
       gregkh@suse.de, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.12 udev hangs at boot
References: <200506181332.25287.nick@linicks.net> <42B45173.6060209@pobox.com> <200506181806.49627.nick@linicks.net> <200506201304.10741.vda@ilport.com.ua>
In-Reply-To: <200506201304.10741.vda@ilport.com.ua>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Denis.

> After all, udev is tied to /sys layout which changes with kernel
> and also udev is vital for properly functioning boot process

Not if you use a static /dev.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)

iD8DBQFCtpe0Brn2kJu9P78RAhrmAJ9EhCY1JQu0bkU3Tx8xP+oGc6/eHQCbBybu
hjZMEAlLc9gPc7vl238LtEE=
=9FdR
-----END PGP SIGNATURE-----
