Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265856AbUBJN2I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 08:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265865AbUBJN2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 08:28:08 -0500
Received: from mail.eris.qinetiq.com ([128.98.1.1]:20828 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S265856AbUBJN2F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 08:28:05 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Dan Hopper <ku4nf@austin.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Promise PDC20378 PATA support?
Date: Tue, 10 Feb 2004 13:22:33 +0000
User-Agent: KMail/1.5.3
References: <20040207071023.GA2304@yoda.dummynet>
In-Reply-To: <20040207071023.GA2304@yoda.dummynet>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200402101322.34183.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> Hi,
>
> Has anyone had any luck getting PATA working on Promise PDC20378

If this is the controller that appears on motherboards like the MSI KT4 Ultra 
(Via KT400 chipset) then the PATA port works just fine in 2.4.x (x >= 22)

I'll have a dig in dmesg when I get home and find the relevant lines.

Mark.


- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAKNsaBn4EFUVUIO0RAsppAKDU7QpIbt7RPWkhktikvMIIMZ9rugCeLRDV
xYyYO0HsPitfnaiNKTF99h4=
=98Oy
-----END PGP SIGNATURE-----

