Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbTJRLL2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 07:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbTJRLL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 07:11:28 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:15338 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261522AbTJRLL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 07:11:26 -0400
Date: Sat, 18 Oct 2003 12:11:22 +0100
From: John Madden <maddenj@skynet.ie>
To: linux-kernel@vger.kernel.org
Subject: Intel Pro/Wireless 2100
Message-ID: <20031018111122.GA29975@skynet.ie>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-PGP-Key: http://www.skynet.ie/~maddenj/maddenj.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hey,

I've already posted his question to the linux-net mailing list but got
no reply, so apologies for anyone who sees it twice.

I'm wondering if anyone has had any luck getting one of the above cards
working under linux. I run either 2.4.22-ac4 or 2.6.0-test7 on a Dell
Inspiron 500M which has an Intel Pro/Wireless 2100 MiniPCI in built.

The following url gives some small bit of information on the chipset in
the second last paragraph:

<quote from
http://www.spectrumresellers.com/publications/page207-480299.asp>

The Intel PRO/Wireless 2100 LAN MiniPCI Adapter consists of
Intel-developed silicon that supports the 802.11b MAC, an 802.11b
baseband chip that is the result of an Intel and Symbol Technologies(a)
Joint Development Agreement (JDA) and utilizes technology designed and
manufactured by Texas Instruments (TI)(a), and an 802.11b radio chip
supplied by Royal Philips Electronics(a).
</quote>

I've tried both the spectrum24 and orinoco drivers to no avail. If
anyone has had any luck getting this working, can you let me know. On
the other hand, if someone is developing a driver and I can be of any
assistance, please let me know.

I've attached the output from lspci -v for the device in question. If
you need any more information on the card, let me know. 

Also, can you cc me in replies as I'm not a subscriber to this list.

- -- 
Chat ya later,

John.
- --
BOFH excuse #1: clock speed
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/kR/MQBw+ZtKOvTIRArZ5AJ49ipImyobG3zKrZVthjmjq0uI9dgCdFgGq
v0GKt88JwHUEouISCkgMrPo=
=XebZ
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename=lspci

01:03.0 Network controller: Intel Corp.: Unknown device 1043 (rev 04)
		Subsystem: Intel Corp.: Unknown device 2561
		Flags: bus master, medium devsel, latency 32, IRQ 11
		Memory at fcff000 (32-bit, non-prefetchable) [size=4K]
		Capabilities: [dc] Power Management version 2

--FL5UXtIhxfXey3p5--
