Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263849AbTKXTOY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 14:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263850AbTKXTOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 14:14:24 -0500
Received: from 67-122-122-226.ded.pacbell.net ([67.122.122.226]:55944 "EHLO
	siamese.3ware.com") by vger.kernel.org with ESMTP id S263849AbTKXTOW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 14:14:22 -0500
Message-ID: <A1964EDB64C8094DA12D2271C04B8126F8C7CE@tabby>
From: Adam Radford <aradford@3WARE.com>
To: "'H. Peter Anvin'" <hpa@zytor.com>, Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: data from kernel.bkbits.net
Date: Mon, 24 Nov 2003 11:14:15 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This looks like glitchy power cables, drive cable or dying drive to me.

-Adam

-----Original Message-----
From: H. Peter Anvin [mailto:hpa@zytor.com]
Sent: Sunday, November 23, 2003 11:35 PM
To: Larry McVoy
Cc: linux-kernel@vger.kernel.org
Subject: Re: data from kernel.bkbits.net


Larry McVoy wrote:
> I've been trying to get all the data off the drives on the machine which
> was broken into.  I have a feeling that whoever this was was hiding stuff
> in the file system because both drives will not fsck clean nor will they
> completely read.
> 
> I've managed to get most of the data off but not all.  Given that I've put
> about 3 days into this I'm pretty much done.  If someone else wants to
look
> at the drives I can make them available, let me know.  But just reading
the
> main drive makes the kernel (Fedora 1) kill the tar process as below (it
> also managed to wack the system enough that it overwrote the NVRAM with
> garbage).  It hasn't been a fun weekend.
> 

Looks more like a 3Ware driver bug to me.  Hard to say for sure, though.

	-hpa

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


DISCLAIMER: The information contained in this electronic mail transmission
is intended by 3Ware for the use of the named individual or entity to which
it is directed and may contain information that is confidential or
privileged and should not be disseminated without prior approval from 3ware 


