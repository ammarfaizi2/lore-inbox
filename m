Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUBZOcA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 09:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUBZOcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 09:32:00 -0500
Received: from mail.eris.qinetiq.com ([128.98.1.1]:9560 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S261186AbUBZOb5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 09:31:57 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Andre Tomt <andre@tomt.net>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Serial ATA (SATA) status report
Date: Thu, 26 Feb 2004 14:23:56 +0000
User-Agent: KMail/1.5.3
References: <403D5B3D.6060804@pobox.com> <200402260913.15379.m.watts@eris.qinetiq.com> <403DF26E.8020908@tomt.net>
In-Reply-To: <403DF26E.8020908@tomt.net>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200402261423.56448.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Mark Watts wrote:
> > Which one of these chips are the 3Ware cards based on?
>
> None of them. 3ware has its own chip, supported by the 3w-xxxx driver in
> mainline 2.4 and 2.6. It's basicly exports the logical arrays as SCSI
> devices.

Neat. Are there any known issues with these cards? (Do they work with AMD-64?)

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAPgF8Bn4EFUVUIO0RAg/JAJ9L5vNQVaoW37ElAc+OIPOJUusvCgCg4YrA
b2+lYzV5MVt820JH+PLD3Vs=
=ycsm
-----END PGP SIGNATURE-----

