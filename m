Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318374AbSHELPj>; Mon, 5 Aug 2002 07:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318376AbSHELPj>; Mon, 5 Aug 2002 07:15:39 -0400
Received: from mta06ps.bigpond.com ([144.135.25.138]:13020 "EHLO
	mta06ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S318374AbSHELPi>; Mon, 5 Aug 2002 07:15:38 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Tyler Longren <tyler@captainjack.com>, kiza@gmx.net
Subject: Re: 2.4.19, USB_HID only works compiled in, not as module
Date: Mon, 5 Aug 2002 21:14:08 +1000
User-Agent: KMail/1.4.5
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20020805003427.7e7fc9f4.tyler@captainjack.com>
In-Reply-To: <20020805003427.7e7fc9f4.tyler@captainjack.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200208052114.15020.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 5 Aug 2002 15:34, Tyler Longren wrote:
> Just to let you know, this problem isn't just happening to you.
>
> I compiled 2.4.19 using the same config file I used for 2.4.18 (yes, I
> also turned on CONFIG_USB_HIDINPUT).  Needless to say, the mouse didn't
> work on reboot.  I saw your post and compiled everything into the
> kernel, and everything worked great on reboot.  So, I think this is
> probably a real 2.4.19 problem.  Not something specific to you.
I'm taking a look now.

Could you (and anyone else with the same problem), mail me the
lines from .config that matches CONFIG_USB for a configuration
that fails to work. Off list would be best.

Brad


- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9Tl4EW6pHgIdAuOMRAoEBAJ9piHXXDBkTOld/qbnzmtDxQ7ZtAwCgjFaH
5yYd+4JaF1SgMVQXlU3EEj0=
=G+vj
-----END PGP SIGNATURE-----

