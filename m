Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263373AbTJKSLG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 14:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbTJKSLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 14:11:06 -0400
Received: from mout0.freenet.de ([194.97.50.131]:16513 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S263373AbTJKSLD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 14:11:03 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Nuno Silva <nuno.silva@vgertech.com>
Subject: Re: [2.6-test7] [bttv] lots of warning/error messages
Date: Sat, 11 Oct 2003 20:10:41 +0200
User-Agent: KMail/1.5.4
References: <200310091729.30465.mbuesch@freenet.de> <20031010090955.GE32386@bytesex.org> <3F8787CA.3030607@vgertech.com>
In-Reply-To: <3F8787CA.3030607@vgertech.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Gerd Knorr <kraxel@bytesex.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310112011.00441.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 11 October 2003 06:32, Nuno Silva wrote:
> I *had* the same problem. It's was not the signal so I persued the other
> hint: "high irq latency?"
>
> I opened the box and saw the NIC in slot 2 and winTV in slot3 and
> switched them. Never saw this message again :)

It was already in the first free PCI-slot, but I changed it nevertheless.
But these messages are still there.

> Thanks,
> Nuno Silva

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]
Animals on this machine: some GNUs and Penguin 2.6.0-test7

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/iEe0oxoigfggmSgRAvn4AJkBNbUskYg6T2tURqNkKE4YtKEVlwCfQXTe
VBkGBHBQvfEFf4Eyg7oUWt8=
=7zM9
-----END PGP SIGNATURE-----

