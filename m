Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264124AbUEMLpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbUEMLpM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 07:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264131AbUEMLpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 07:45:12 -0400
Received: from panda.sul.com.br ([200.219.150.4]:17929 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S264124AbUEMLpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 07:45:04 -0400
Date: Thu, 13 May 2004 08:42:50 -0300
To: Plaz McMan <PlazMcMan@Softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp + APM in 2.6.6
Message-ID: <20040513114250.GB16524@cathedrallabs.org>
References: <1084411449.2562.20.camel@ansel.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
Content-Disposition: inline
In-Reply-To: <1084411449.2562.20.camel@ansel.lan>
From: aris@cathedrallabs.org (Aristeu Sergio Rozanski Filho)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> In 2.6.6, however, using the same kernel configuration, neither
> /proc/sleep or /proc/acpi/sleep exist! I _do_ have swsusp enabled in the
> kernel, as well as ACPI sleep states (do they do anything if you disable
please check
http://marc.theaimsgroup.com/?l=bk-commits-head&m=108423574229098&w=2

- -- 
Aristeu

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAo186RRJOudsVYbMRApr6AKCDzkzlgxslytXKJvdh2ckJ/Z+DLACeLgpf
lPExuMmU42REcBA27D2p0ok=
=AkG5
-----END PGP SIGNATURE-----
