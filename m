Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264781AbUGMKqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264781AbUGMKqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 06:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264857AbUGMKqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 06:46:00 -0400
Received: from mail.eris.qinetiq.com ([128.98.1.1]:7450 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S264781AbUGMKp6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 06:45:58 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: Re: HDIO_SET_DMA failed on a Dell Latitude C400 Laptop
Date: Tue, 13 Jul 2004 11:41:21 +0100
User-Agent: KMail/1.6.1
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
References: <200407121407.14428.m.watts@eris.qinetiq.com> <200407121422.00841.m.watts@eris.qinetiq.com> <200407121737.34189.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200407121737.34189.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200407131141.21973.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Make sure that you have the driver for your IDE chipset compiled-in or
> (if you are using IDE as module) that you load it and not ide-generic.

Fixed - thanks.

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA87xRBn4EFUVUIO0RAtzHAJkBflHLY/ZwYPaBUanexrmOxJlF5gCg61cD
SlpyH+LHjozE6FUGZNSRjrI=
=wh7k
-----END PGP SIGNATURE-----
