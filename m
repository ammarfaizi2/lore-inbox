Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265602AbUBPPUB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 10:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265620AbUBPPUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 10:20:00 -0500
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:8080 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S265602AbUBPPT4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 10:19:56 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Ryan Reich <ryanr@uchicago.edu>, linux-kernel@vger.kernel.org
Subject: Re: Speaker static, vanishes with APIC
Date: Mon, 16 Feb 2004 15:12:11 +0000
User-Agent: KMail/1.5.3
References: <Pine.LNX.4.58.0402150903010.1774@ryanr.aptchi.homelinux.org>
In-Reply-To: <Pine.LNX.4.58.0402150903010.1774@ryanr.aptchi.homelinux.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200402161512.12171.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> This is really trivial and I solved it anyway, but in all incarnations of
> 2.6 I have had static coming from my speakers shortly after boot.  It only
> lasts a few seconds and sounds as though someone were jiggling the plug in
> the sound card's socket.  It only happens right after boot.  Since I
> enabled Local APIC and IO-APIC it hasn't happened.

Did you get a similar noise when shutting down?

My other half has an AMD motherboard with onboard Via sound which gives a 
burst of static when KDE 3.1 starts and another when it shuts down. All other 
sound is fine. (Kernel 2.4.22)

APIC's are disabled on this board...

>
> Sound card module is snd-intel8x0, and my card is built into my Shuttle
> AN35N motherboard.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAMN3MBn4EFUVUIO0RAmhpAKDBdNa+o+oSxN3IzJr2r1Mxah2UMQCdFsAh
AzdX+KW9ljMZg3Yr5a0fmNY=
=yIyB
-----END PGP SIGNATURE-----

