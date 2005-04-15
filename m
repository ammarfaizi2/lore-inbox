Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVDOHc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVDOHc0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 03:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVDOHc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 03:32:26 -0400
Received: from mailgw1.fraunhofer.de ([153.96.1.62]:30903 "EHLO
	mailgw1.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261755AbVDOHcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 03:32:20 -0400
Message-ID: <425F6E27.6040903@gmx.de>
Date: Fri, 15 Apr 2005 09:32:55 +0200
From: Andre Bender <andre.bender@gmx.de>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tomasz Chmielewski <mangoo@interia.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: poor SATA performance under 2.6.11 (with < 2.6.11 is OK)?
References: <425E9902.8000804@interia.pl> <20050414165535.GA15440@irc.pl> <425EE9CF.4030202@interia.pl> <20050414223417.GA23013@shell0.pdx.osdl.net> <425F6C48.9060505@interia.pl>
In-Reply-To: <425F6C48.9060505@interia.pl>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Fraunhofer-Email-Policy: accepted
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Tomasz Chmielewski wrote:
> 
> OK so Tomasz Torch suggested that my drive was blacklisted somewhere
> after 2.6.8.1 (it's the last kernel on which I have good performance).
> 
> Does drive blacklisting = very poor performance?
> And no drive blacklisting = good performance, and possibly data corruption?
> 

That's what has already been told some posts ago. The kernel developers
don't blacklist anything that works just for fun. There seems to be a
serious problem when combining this pieces of hardware so the
combination is blacklisted to get it working properly but with (much)
less performance.

cu

- --

- -----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GCS d-(--) s++:-a- c++(++) UL+++(+) P--- L++ ! EW++ !N !o K? w--- O@ M?
V? PS+
PE- Y+ PGP+++ t+ 5++ X++ R+ tv+ b++ DI- D+ Ge+++ hr(-) y+(+)
- ------END GEEK CODE BLOCK------

They say that when you play a Microsoft CD backwards you can hear
demonic voices...
But that's nothing - When you play it forwards it installs Windows

- -------------------------------

My public key can be found at
     http://www.keyserver.net
my fingerprint is
     302C FD91 2CE0 487E E086 EEBC D8D9 2865 E32F 4D56
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCX24m29koZeMvTVYRAharAJ4r4aCCuDNt+B0zjv88tGgOEQIGMACgsVYm
xibnwIYSV+8LUcnXaMImorE=
=NHfy
-----END PGP SIGNATURE-----
