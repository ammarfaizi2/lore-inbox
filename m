Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263989AbSITXYH>; Fri, 20 Sep 2002 19:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263997AbSITXYH>; Fri, 20 Sep 2002 19:24:07 -0400
Received: from mta02ps.bigpond.com ([144.135.25.134]:37096 "EHLO
	mta02ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S263989AbSITXYG>; Fri, 20 Sep 2002 19:24:06 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: David Brownell <david-b@pacbell.net>, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: 2.5.26 hotplug failure
Date: Sat, 21 Sep 2002 09:22:41 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
References: <200207180950.42312.duncan.sands@wanadoo.fr> <20020919230643.GD18000@kroah.com> <3D8B884A.7030205@pacbell.net>
In-Reply-To: <3D8B884A.7030205@pacbell.net>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200209210922.41887.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sat, 21 Sep 2002 06:42, David Brownell wrote:
> >>I wasn't joking about putting back the /proc/bus/usb/drivers file. This
> >> is really going to hurt us in 2.6.
>
> Considering that the main use of that file that I know about was
> implicit (usbfs is available if its files are present, another
> assumption broken in 2.5), I'm not sure I feel any pain... :-)
OK. Everytime someone goes "I've got usbfs loaded, and here is 
/proc/bus/usb/devices, but can't send you /proc/bus/usb/drivers", I'll assume 
that you two will answer the question.

Helping people is hard. Please don't make it harder. :-(

Brad

- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9i63BW6pHgIdAuOMRAmylAKCFgC9OMHhzzLT9ac+Z+YHSNkn0IACeJsCe
MxFG9+07RZh1QnDAE27/FqI=
=vwfj
-----END PGP SIGNATURE-----

