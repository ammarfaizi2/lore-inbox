Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUF0TVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUF0TVZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 15:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUF0TVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 15:21:25 -0400
Received: from ms-1.rz.RWTH-Aachen.DE ([134.130.3.130]:27524 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S261951AbUF0TVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 15:21:10 -0400
Date: Sun, 27 Jun 2004 21:22:41 +0200
From: Alexander Gran <alex@zodiac.dnsalias.org>
Subject: Re: [ACPI] No APIC interrupts after ACPI suspend
In-reply-to: <200406272052.43326@zodiac.zodiac.dnsalias.org>
To: Hamie <hamish@travellingkiwi.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Message-id: <200406272122.45609@zodiac.zodiac.dnsalias.org>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
X-Ignorant-User: yes
References: <1088160505.3702.4.camel@tyrosine>
 <40DF0A98.9040604@travellingkiwi.com>
 <200406272052.43326@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Sonntag, 27. Juni 2004 20:52 schrieb Alexander Gran:
> Sound doesn't.
> unloading/reloading the sound driver does not help.
> USB works jumpy (perhaps 5-10hz)
> Reloading does the trick for usb.

Oh, sorry. That one was incorrect.
reloading the usb drivers does only help on 2.6.7-mm2 without bk-acpi.patch. 

regards
Alex

- -- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3x6E/aHb+2190pERAiwgAJ93jDFzhcTUy3MR0M4kHuqvXxIL9gCeIkUt
KGA555USeLuPnYTVKjQJAzk=
=nA8V
-----END PGP SIGNATURE-----

