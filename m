Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTIYNti (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 09:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbTIYNth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 09:49:37 -0400
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:25730 "HELO
	longlandclan.hopto.org") by vger.kernel.org with SMTP
	id S261245AbTIYNtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 09:49:36 -0400
Message-ID: <3F72F1F6.1040007@longlandclan.hopto.org>
Date: Thu, 25 Sep 2003 23:47:34 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
CC: Adrian Bunk <bunk@fs.tum.de>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: PS2 keyboard & mice mandatory again ?
References: <1064428364.1673.11.camel@rousalka.dyndns.org>	 <20030925074656.GA22543@ucw.cz>	 <1064477341.13077.7.camel@ulysse.olympe.o2t>	 <20030925111547.GL15696@fs.tum.de> <1064491863.17990.10.camel@ulysse.olympe.o2t>
In-Reply-To: <1064491863.17990.10.camel@ulysse.olympe.o2t>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Nicolas Mailhot wrote:
| Le jeu 25/09/2003 à 13:15, Adrian Bunk a écrit :
|
|>On Thu, Sep 25, 2003 at 10:11:45AM +0200, Nicolas Mailhot wrote:
|>
|>>Great, now a standard mass-market computer is an embedded device. I can
|>>(and will) certainly do it, but this looks like a ticking bomb to me.
|>>...
|>
|>What does it cost if an unneeded driver is included in your kernel?
|>Perhaps a few kB?
|
|
| And all the bugs of the unneeded driver.
| I didn't notice this because I have the habit to run diff between my old
| and new config. I noticed it because on 2.6.0-test-bk9 or 10 I had my
| boot logs full of warnings associated to PS/2 input.
|

I presonally would like to be able to choose if I want to use the PS/2
driver or not.  Mainly because a couple of machines I have here, use the
old AT keyboard (DIN-5 connection, not PS/2 or USB), and have <128MB
RAM.  For instance, how many 386 computers have you seen with at least
32MB RAM & PS/2 or USB sockets? [1]

(And yes, I probably would be crazy enough to go put Linux 2.6 on to a
386, I've considered installing Gentoo on one actually -- just to see
how long it takes :-D)

Footnotes:
1. I've only seen one exception to this, that is one old (also dead)
Olivetti 386 laptop which had PS/2 keyboard & mouse sockets.

- --
+-------------------------------------------------------------+
| Stuart Longland           stuartl at longlandclan.hopto.org |
| Brisbane Mesh Node: 719             http://stuartl.cjb.net/ |
| I haven't lost my mind - it's backed up on a tape somewhere |
| Griffith Student No:           Course: Bachelor/IT (Nathan) |
+-------------------------------------------------------------+
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/cvH2IGJk7gLSDPcRAogxAJ98vnGjv28e66WfQeB/1vGvsJpcdQCcClTN
irImF4+gNHZq2yi0CTbeTQI=
=9If5
-----END PGP SIGNATURE-----

