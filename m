Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVA1QbC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVA1QbC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 11:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbVA1QbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 11:31:02 -0500
Received: from mailr.eris.qinetiq.com ([128.98.1.9]:12698 "HELO
	mailr.qinetiq-tim.net") by vger.kernel.org with SMTP
	id S261467AbVA1Qaz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 11:30:55 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Dan Williams <dcbw@redhat.com>
Subject: Re: Where Linux 802.11x support needs work
Date: Fri, 28 Jan 2005 16:38:08 +0000
User-Agent: KMail/1.6.1
References: <Pine.LNX.4.58.0501251630280.30850@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.58.0501251630280.30850@devserv.devel.redhat.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200501281638.08372.m.watts@eris.qinetiq.com>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.29.0.5; VDF: 6.29.0.52; host: mailr.qinetiq-tim.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



> o  Firmware issues
>    1) Cisco aironet firmware upload is quite inconsistent, fails with
>       5.21 for example.  Firmware <= 5.02 seems to be required for using
>       WEP with most access points.  Latest Cisco-provided driver is quite
>       different than latest in-kernel driver

This might explain why I've never managed to get WEP working with my cisco 
cards...

Is there some documentation somewhere on exactly what firmware/driver/kernel 
versions you need to make WEP work with aironet cards?

Cheers,

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB+mpwBn4EFUVUIO0RAg+qAKDP9f3uV0YQfN/kj/Wp04NHtoTNJgCggun1
IhMCNDTQ2sIPollnKE3SXNk=
=pKy+
-----END PGP SIGNATURE-----
