Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288660AbSANCRo>; Sun, 13 Jan 2002 21:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288662AbSANCQi>; Sun, 13 Jan 2002 21:16:38 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:54289 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288660AbSANCQR>; Sun, 13 Jan 2002 21:16:17 -0500
Message-ID: <3C423E13.8A164D72@zip.com.au>
Date: Sun, 13 Jan 2002 18:10:27 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18pre3-ac1-aia21 (IDE patches)
In-Reply-To: <5.1.0.14.2.20020113232757.04f34ec0@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> Alan's -ac series is back! To celebrate this I added in the IDE patches and
> an NTFS update which dramatically reduces the number of vmalloc()s and have
> posted the resulting (tested) patch (to be applied on top of
> 2.4.18pre3-ac1) at below URL.
> 

Is that the NTFS code which produces eighty five quintillion warnings
with the recommended gcc versions? :-)

-
