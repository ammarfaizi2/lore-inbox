Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbTIFS4W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 14:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTIFS4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 14:56:22 -0400
Received: from mout0.freenet.de ([194.97.50.131]:17644 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S261473AbTIFS4V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 14:56:21 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: maxo@myrealbox.com
Subject: Re: bug/request: multi-processing for CD devices
Date: Sat, 6 Sep 2003 20:56:15 +0200
User-Agent: KMail/1.5.3
References: <200309061945.30402.maxo@myrealbox.com>
In-Reply-To: <200309061945.30402.maxo@myrealbox.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200309062056.19023.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 06 September 2003 21:45, Max O'Shea wrote:
> Hello,

Hi,

> Summary: request for multi-processing for CD devices (I think the word is
> 'multi-processing' - ie. so that you can play an audio CD and browse the
> audio CD using a program such as konqueror at the same time)
>
> Full description: At the moment, if you are playing an audio CD with one
> program and you start accessing the audio CD with another program, the
> music will stop playing.

As far as I know that should be impossible, because audio-playing
runs 100% on the cd-rom hardware itself. The OS has nothing to do
with it.
So your request should go to the device manufacturers and ask
them if they could build devices, that are "multithreaded". :)
(But it maybe, that this was total crap and I better had thrown
this mail to /dev/null. I'm not 100% sure. 8-) )

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]
Animals on this machine: some GNUs and Penguin 2.6.0-test4-bk2

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Wi3PoxoigfggmSgRAv7nAJ9FWCFjuLcrSgqfxWWaOXvWZ7A3wACZAf3r
X1KNMtG5lO0ptS7/cVt4qV8=
=NZoP
-----END PGP SIGNATURE-----

