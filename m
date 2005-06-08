Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVFHPnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVFHPnM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 11:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVFHPnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 11:43:12 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:34025 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261310AbVFHPnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 11:43:08 -0400
Message-ID: <42A711FE.2080004@casabyte.com>
Date: Wed, 08 Jun 2005 08:42:54 -0700
From: Robert White <rwhite@casabyte.com>
Organization: Casabyte, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Kumar Gala <kumar.gala@freescale.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: stupid SATA questions
References: <10d4b7cd189d7b661a84e765ab8cce93@freescale.com> <42A5E0BF.8000103@pobox.com>
In-Reply-To: <42A5E0BF.8000103@pobox.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Since the title of the thread applies...

What command (or whatever) does one use to do things like set the power
controls on a libata-controlled SATA drive?  hdparm doesn't seem to do
anything but complain when I try to use the various features.

hdparm /dev/sda
/dev/sda:
 IO_support   =  0 (default 16-bit)
 ...

Does the "16-bit" mean anything or is it just a bogon?

Rob White

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCpxH+MLJWEiVQHi0RAnVfAJ96cbdPbhXe5EAoIoac49MOyKL6dACfbxN6
pVdoURM9Ebxzuo9dC+DWxEE=
=Ys/d
-----END PGP SIGNATURE-----
