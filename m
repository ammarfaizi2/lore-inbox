Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTFXQFv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 12:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTFXQFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 12:05:51 -0400
Received: from pointblue.com.pl ([62.89.73.6]:7945 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262093AbTFXQFu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 12:05:50 -0400
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Organization: K4 Labs
To: Asfand Yar Qazi <email@asfandyar.cjb.net>, linux-kernel@vger.kernel.org
Subject: Re: Does a patch exist to override the 2GB vfat limit on 2.4.21?
Date: Tue, 24 Jun 2003 16:49:05 +0100
User-Agent: KMail/1.5.9
References: <3EF87637.1090109@asfandyar.cjb.net>
In-Reply-To: <3EF87637.1090109@asfandyar.cjb.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200306241649.11615@gjs>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 24 of June 2003 17:03, Asfand Yar Qazi wrote:
> The 2GB limit on vfat is quite troublesome, especially as the big hard
> disk is shared with Windoze (for the family :-( ) and I need all that
> luvverly space.
2.4.21 is working fine on 2GB> files, all you need is an proper glibc afaik.

- -- 
Grzegorz Jaskiewicz
K4 Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE++HL1qu082fCQYIgRAk/aAJ0WcmGaNAX7F50Yit32dOMMGUzyLgCdFnwR
0JKFiAUhjmTQub/bLySxGO0=
=LJLZ
-----END PGP SIGNATURE-----
