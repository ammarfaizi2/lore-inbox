Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264473AbUBOLXP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 06:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbUBOLXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 06:23:14 -0500
Received: from c181144.adsl.hansenet.de ([213.39.181.144]:32923 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S264473AbUBOLWx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 06:22:53 -0500
Message-ID: <402F5686.2000307@portrix.net>
Date: Sun, 15 Feb 2004 12:22:46 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Jordan <RomanJordan@gmx.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ALSA Sound and BT 878
References: <1076842492.3053.2.camel@darkstar>
In-Reply-To: <1076842492.3053.2.camel@darkstar>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFC175E7C062B6BAEDE8E9155"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFC175E7C062B6BAEDE8E9155
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Roman Jordan wrote:
> Hi,
> i can't found a configuration entry for the bt878 sound device
> (television card) and the new ALSA architecture. Can i use ALSA and the
> bt 878 chip without OSS?
> 

You normally don't need the bt878 sound driver. In most setups the audio 
is passed through the soundcard with an external cable.
Though, if you need the features of the sound driver, you'll have to 
enable oss. It will co-exists nicely with alsa.

Regards,

Jan

--------------enigFC175E7C062B6BAEDE8E9155
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAL1aLLqMJRclVKIYRAp36AJ0c6doo/9vYEkHk7qHLg5qnQpGAqQCfbTPI
TJFK7ziXR9IaT98JOZE6xhk=
=WcOC
-----END PGP SIGNATURE-----

--------------enigFC175E7C062B6BAEDE8E9155--
