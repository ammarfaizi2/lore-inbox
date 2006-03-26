Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWCZJxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWCZJxx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 04:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWCZJxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 04:53:53 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:45290 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751210AbWCZJxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 04:53:52 -0500
Message-ID: <44266499.3070809@t-online.de>
Date: Sun, 26 Mar 2006 11:53:29 +0200
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Schedule for adding pata to kernel? 
References: <1142869095.20050.32.camel@localhost.localdomain> <4422F10B.9080608@bootc.net>
In-Reply-To: <4422F10B.9080608@bootc.net>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF0EA07961D91532C6BF67888"
X-ID: ZBj5tUZ6oe2KbshwY6VHW4OQJhnhUZs7t23SlvHQNBUJrfoeG-nT4I
X-TOI-MSGID: 6a6aae10-90ed-40e2-86eb-376822ab6f53
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF0EA07961D91532C6BF67888
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Alan,

Works for me, too. Is there a plan to add this to the source tree?

0000:00:1f.2 IDE interface: Intel Corporation 82801FB/FW (ICH6/ICH6W) SATA Controller (rev 04)
0000:00:1f.2 0101: 8086:2651 (rev 04)


Many thanx

Harri
======================================================================
Chris Boot wrote:
> Hi Alan,
> 
> Alan Cox wrote:
> 
>> Can be found at the usual location
>>
>>     http://zeniv.linux.org.uk/~alan/IDE
>>
>> Some further small changes and updates, in particular the use of
>> platform device class for VLB/ISA/legacy IDE ports and the removal of
>> the "no device" special cases from the core.
>>
>> Alan
> 
> 
> If you're still looking for success reports, I just burned a DVD on
> 2.6.16-ide1 just fine. At the final stages of burning I got a few
> messages about the burner not being ready but it kept trying and
> eventually succeeded writing the lead-out. DVD works fine.
> 
> Still not tried the pesky tape drive, those tapes I ordered weeks ago
> are still on back order! It is detected properly and claimed by 'st'
> through.
> 
> HTH,
> Chris
> 

--------------enigF0EA07961D91532C6BF67888
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEJmSZUTlbRTxpHjcRAmhtAKCM8u0nxPIWJrPrHQdn/K8lKJfhQwCfT84u
/7B7mCXszgXWujEycTZS8rE=
=DRWh
-----END PGP SIGNATURE-----

--------------enigF0EA07961D91532C6BF67888--
