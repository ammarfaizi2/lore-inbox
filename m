Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275270AbSIUA1T>; Fri, 20 Sep 2002 20:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275320AbSIUA1T>; Fri, 20 Sep 2002 20:27:19 -0400
Received: from mta04bw.bigpond.com ([139.134.6.87]:4595 "EHLO
	mta04bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S275270AbSIUA1S>; Fri, 20 Sep 2002 20:27:18 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Johannes Erdfelt <johannes@erdfelt.com>
Subject: Re: [linux-usb-devel] Re: 2.5.26 hotplug failure
Date: Sat, 21 Sep 2002 10:25:58 +1000
User-Agent: KMail/1.4.5
Cc: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <200207180950.42312.duncan.sands@wanadoo.fr> <200209210922.41887.bhards@bigpond.net.au> <20020920193642.I1627@sventech.com>
In-Reply-To: <20020920193642.I1627@sventech.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209211025.59114.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sat, 21 Sep 2002 09:36, Johannes Erdfelt wrote:
> Personally, I've never used /proc/bus/usb/drivers. I've always just
> looked at lsmod.
>
> Why should this be any different?
Because lsmod only works for drivers that are modular. Real users mix built-in 
and modules.

Brad

- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9i7yXW6pHgIdAuOMRAhaVAJ9r7DqZ8N5Zyq/V2TCKfnFDEYC1awCghryW
sx2q98LjfXpiSgzW0gGPZC4=
=mzPE
-----END PGP SIGNATURE-----

