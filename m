Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282945AbRLCIsY>; Mon, 3 Dec 2001 03:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281810AbRLBVfr>; Sun, 2 Dec 2001 16:35:47 -0500
Received: from mail018.mail.bellsouth.net ([205.152.58.38]:62319 "EHLO
	imf18bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281807AbRLBVfb>; Sun, 2 Dec 2001 16:35:31 -0500
Message-ID: <3C0A9E9E.FA0126A5@mandrakesoft.com>
Date: Sun, 02 Dec 2001 16:35:26 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.4.17.2: make ext2 smaller
In-Reply-To: <3C0A1105.18B76D64@mandrakesoft.com> <3C0A9D8D.4CC463A0@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> but, but, but...   That's on-disk size.
> 
> What does /usr/bin/size say?

read further down in the thread, there is /usr/bin/size savings as well


> And don't forget http://www.zip.com.au/~akpm/linux/2.4/2.4.17-pre1/inline.patch
> which deletes 61 `inline's and save 12 kbytes.  We really, really
> need to examine our use of inlines.

agreed.  a review of inlines has been needed for a while

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

