Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313592AbSDQT63>; Wed, 17 Apr 2002 15:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313887AbSDQT62>; Wed, 17 Apr 2002 15:58:28 -0400
Received: from ausxc10.us.dell.com ([143.166.98.229]:19720 "EHLO
	ausxc10.us.dell.com") by vger.kernel.org with ESMTP
	id <S313592AbSDQT61>; Wed, 17 Apr 2002 15:58:27 -0400
Message-ID: <8C70996FDCA44C4180A2A6E2AB3B069F28CF04@ausxmps101.us.dell.com>
From: Adam_Kessler@Dell.com
To: greg@kroah.com, gowdy@slac.stanford.edu
Cc: torvalds@transmeta.com, david-b@pacbell.net,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: RE: [linux-usb-devel] Re: [BK PATCH] USB device support for 2.5.8
	 (take 2)
Date: Wed, 17 Apr 2002 14:58:25 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I like gadget! It's unambiguous namespace with a ring.

Target sounds to much like a cross-compiler; and boring.

-----Original Message-----
From: Greg KH [mailto:greg@kroah.com]
Sent: Wednesday, April 17, 2002 1:32 PM
To: Stephen J. Gowdy
Cc: Linus Torvalds; David Brownell;
linux-usb-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB device support for
2.5.8 (take 2)


On Wed, Apr 17, 2002 at 11:41:14AM -0700, Stephen J. Gowdy wrote:
> gadget? non-host?

"gadget" is nice.  It's descriptive of what the code is for, without the
bad connotations that "slave" seems to have.

Although those people who actually take USB seriously might not like it
so much, but I don't see any of those people doing Linux development
anyway :)

thanks,

greg k-h
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
