Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVAQQZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVAQQZp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 11:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbVAQQZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 11:25:44 -0500
Received: from mailr.eris.qinetiq.com ([128.98.1.9]:64706 "HELO
	mailr.qinetiq-tim.net") by vger.kernel.org with SMTP
	id S262172AbVAQQZf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 11:25:35 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: Re: brought up 4 cpu's
Date: Mon, 17 Jan 2005 16:32:26 +0000
User-Agent: KMail/1.6.1
Cc: kladit@t-online.de (Klaus Dittrich)
References: <20050117153646.GA25273@xeon2.local.here> <200501171609.15054.m.watts@eris.qinetiq.com> <41EBE54B.1010401@xeon2.local.here>
In-Reply-To: <41EBE54B.1010401@xeon2.local.here>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200501171632.26443.m.watts@eris.qinetiq.com>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.29.0.5; VDF: 6.29.0.52; host: mailr.qinetiq-tim.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Mark Watts wrote:
> >-----BEGIN PGP SIGNED MESSAGE-----
> >Hash: SHA1
> >
> >>kernel-2.6.11-rc1-bk5 stops booting after the message
> >>"Brought up 4 CPU'S"
> >>
> >>System is Dual-P4.
> >
> >With HyperThreading?
> >
> >- --
> >Mark Watts
> >Senior Systems Engineer
> >QinetiQ Trusted Information Management
> >Trusted Solutions and Services group
> >GPG Public Key ID: 455420ED
> >
> >-----BEGIN PGP SIGNATURE-----
> >Version: GnuPG v1.2.4 (GNU/Linux)
> >
> >iD8DBQFB6+MrBn4EFUVUIO0RAtBrAJ465HkQ8WVNIx2BXoI+RB7tByIEOQCg3cWo
> >z99P6VMPsaBKYiiPPhuIaDw=
> >=f0sH
> >-----END PGP SIGNATURE-----
>
> Yes, 2 XEON/P4.

Thats your answer then. HyperThreading makes one cpu act as two (with a 
suitable performance increase for some workloads)

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB6+iaBn4EFUVUIO0RAv6UAKCPVfzInuwygs7+MwVoCoTspzk+9wCg3FCu
0HLcxhzoj+R3ByPPZJ2cqH8=
=TQ1B
-----END PGP SIGNATURE-----
