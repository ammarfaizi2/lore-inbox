Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266501AbUGPJR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266501AbUGPJR6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 05:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266502AbUGPJQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 05:16:55 -0400
Received: from mail.eris.qinetiq.com ([128.98.1.1]:50583 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S266509AbUGPJQp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 05:16:45 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: Re: kernel oops' over serial console
Date: Fri, 16 Jul 2004 10:12:01 +0100
User-Agent: KMail/1.6.1
References: <200407160943.18851.m.watts@eris.qinetiq.com>
In-Reply-To: <200407160943.18851.m.watts@eris.qinetiq.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200407161012.01712.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Whenever I shut my laptop down (running 2.6.8rc1) I see a kernel oops go
> by. How do I hook the laptop up to another box using a serial cable in
> order to capture that oops?
>
> Cheers,
>
> Mark.

console=/dev/ttyS0...

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA95vhBn4EFUVUIO0RAnCSAKDV5fDLgENvQ1GEqglkD3iZYzQQQQCcCgvi
7ncfvuLvcpiphZ5so93CQI4=
=bm+/
-----END PGP SIGNATURE-----
