Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWDUB1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWDUB1D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 21:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWDUB1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 21:27:03 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:8529 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932199AbWDUB1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 21:27:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=qxwRZimfKaV/zCQ2r97a9+4HIWQtbMLdwv+pIpaTA1GB3fowRTIvQRqefeV4afsNG8xkxhCEY4SZjgC578XI+dsk15t2ZASQduyFVIOuziVm44AFNR0mNBynCHlI5UIS0A/od+Zc1SzGyygzmKtm+QEtpX7RU8d3Evmj9evnhyg=
Message-ID: <44483668.7030109@gmail.com>
Date: Fri, 21 Apr 2006 08:33:28 +0700
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
Organization: IcySpace.net
User-Agent: Thunderbird 1.5.0.2 (X11/20060308)
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Which process is associated with process ID 0 (swapper)
References: <4447A19E.9000008@gmail.com> <Pine.LNX.4.61.0604201118200.5749@chaos.analogic.com> <4447B110.4080700@gmail.com> <Pine.LNX.4.61.0604210007140.28841@yvahk01.tjqt.qr> <44481ACE.9040104@gmail.com> <44482963.4030902@trash.net>
In-Reply-To: <44482963.4030902@trash.net>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=65ABD897
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Patrick McHardy wrote:
> - there is no 1:1 mapping between sockets (or packets) and
>   processes. If you use corking even a single packet can be
>   created in cooperation by multiple processes.

Single packet is created by multiple processes? Can you show me some
examples?

Mikado.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESDZoNWc9T2Wr2JcRAp79AJ0eYjeA63dNZnRQ66eKVYhKU8NtRACfcONb
wmo/IW+Yr7zuCXH09qDjq3I=
=XChU
-----END PGP SIGNATURE-----
