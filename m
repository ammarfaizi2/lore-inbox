Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271467AbTGQOkQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 10:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271469AbTGQOkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 10:40:16 -0400
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:37737 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S271467AbTGQOkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 10:40:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: "J. Hidding" <J.Hidding@student.rug.nl>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.0-test1 freezes sometimes
Date: Thu, 17 Jul 2003 15:54:01 +0100
User-Agent: KMail/1.4.3
References: <web-8156551@mail.rug.nl>
In-Reply-To: <web-8156551@mail.rug.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307171554.01825.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> I'm getting very frustated right now, as I seem to be
> unable to find ANY kernel that doesn't freeze. (2.4.21
> this time) I'm beginning to think there's something wrong
> with my machine itself. How can I test my computer for any
> malfunctioning hardware (memory for example, or
> overheating)?

memtest86 for ram (let it run overnight) and lmsensors for temps.

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/FriJBn4EFUVUIO0RAmxYAJ0Qk/hLF4T4WLrEcrYn0yCPb5v1GQCeIrEc
jveQDVtyupdlUSnxnuwX104=
=37Gp
-----END PGP SIGNATURE-----

