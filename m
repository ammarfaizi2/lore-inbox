Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262777AbUKRN3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262777AbUKRN3c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 08:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbUKRN05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 08:26:57 -0500
Received: from salazar.rnl.ist.utl.pt ([193.136.164.251]:46509 "EHLO
	admin.rnl.ist.utl.pt") by vger.kernel.org with ESMTP
	id S262774AbUKRNZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 08:25:39 -0500
Message-ID: <419CA2DA.5070207@mega.ist.utl.pt>
Date: Thu, 18 Nov 2004 13:25:46 +0000
From: Pedro Venda <pjlv@mega.ist.utl.pt>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041006)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Pedro Venda <pjlv@mega.ist.utl.pt>,
       davej@codemonkey.org.uk
Subject: Re: [PATCH] Trivial update: option for default ondemand cpufreq governor
References: <419BF015.3050900@mega.ist.utl.pt> <200411172132.39274.dtor_core@ameritech.net>
In-Reply-To: <200411172132.39274.dtor_core@ameritech.net>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

| See here:
|
| 	http://www.ussg.iu.edu/hypermail/linux/kernel/0408.3/0953.html
|
| "... If transition_latency is high, the ondemand governor initialization
| will fail (User level governor is suggested in this case). Hence it cannot
| be used as a default governor."

ok, thanks. shame on me.

- --

Pedro João Lopes Venda
email: pjlv@mega.ist.utl.pt
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBnKLZeRy7HWZxjWERAotoAJ90fyXTU8zXtqaDIiG2wc5srgjrHQCfaRs8
d1XatsYQUrSvxFe/fuzKk6g=
=Wuxa
-----END PGP SIGNATURE-----
