Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261395AbSITHuq>; Fri, 20 Sep 2002 03:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261397AbSITHup>; Fri, 20 Sep 2002 03:50:45 -0400
Received: from mta05bw.bigpond.com ([139.134.6.95]:50939 "EHLO
	mta05bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S261395AbSITHup>; Fri, 20 Sep 2002 03:50:45 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: compile error in pre7-ac2: usb & input
Date: Fri, 20 Sep 2002 17:49:19 +1000
User-Agent: KMail/1.4.5
Cc: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209191555240.1928-100000@ondatra.tartu-labor> <200209201727.10324.bhards@bigpond.net.au> <20020920094407.A79476@ucw.cz>
In-Reply-To: <20020920094407.A79476@ucw.cz>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209201749.20133.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 20 Sep 2002 17:44, Vojtech Pavlik wrote:
> As of current 2.5 input.o is always built in. (Since CONFIG_INPUT is
> defined to Y).
I guess the embedded guys will just hack it back out, so that seems OK.

Same for 2.4 though?

Brad
- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9itMAW6pHgIdAuOMRAkrCAKDCdgKCC5z6Pt+U9saDDGrJNb3zQACeLyzR
IMLoMaDIPp4ubfs3zCYVKsE=
=HmHm
-----END PGP SIGNATURE-----

