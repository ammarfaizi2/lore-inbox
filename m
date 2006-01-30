Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWA3EFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWA3EFt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 23:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWA3EFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 23:05:48 -0500
Received: from mx6.mail.ru ([194.67.23.26]:52613 "EHLO mx6.mail.ru")
	by vger.kernel.org with ESMTP id S1751233AbWA3EFs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 23:05:48 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Greg KH <greg@kroah.com>
Subject: Re: Does /sys/module/foo reflect external module name?
Date: Mon, 30 Jan 2006 07:05:45 +0300
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200601291914.48318.arvidjaar@mail.ru> <20060129202658.GA7139@kroah.com>
In-Reply-To: <20060129202658.GA7139@kroah.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601300705.45928.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 29 January 2006 23:26, Greg KH wrote:
>
> What would that be needed for?  You can always just compare the list
> with /proc/modules, right?
>

right

> thanks,
>

thanks to you :)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD3ZCZR6LMutpd94wRAiHfAKCbQzRonvgpAYkvKq1yTzWAQD/1MACgoy6D
mg0lJ2j+N06iJWAW7lm2CXw=
=k7HJ
-----END PGP SIGNATURE-----
