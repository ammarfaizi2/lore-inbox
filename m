Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317863AbSGKRS0>; Thu, 11 Jul 2002 13:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317865AbSGKRSZ>; Thu, 11 Jul 2002 13:18:25 -0400
Received: from dsl-213-023-020-056.arcor-ip.net ([213.23.20.56]:17045 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317863AbSGKRSY>;
	Thu, 11 Jul 2002 13:18:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Christian Ludwig" <cl81@gmx.net>, "Ville Herva" <vherva@niksula.hut.fi>
Subject: Re: bzip2 support against 2.4.18
Date: Thu, 11 Jul 2002 19:22:29 +0200
X-Mailer: KMail [version 1.3.2]
Cc: "Linux Kernel Mailinglist" <linux-kernel@vger.kernel.org>
References: <003d01c22819$ba1818b0$1c6fa8c0@hyper> <20020711062832.GU1548@niksula.cs.hut.fi> <002601c228ab$86b235e0$1c6fa8c0@hyper>
In-Reply-To: <002601c228ab$86b235e0$1c6fa8c0@hyper>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17SheA-0002Uh-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 July 2002 09:21, Christian Ludwig wrote:
> Putting in another 4MB into that machine (thus it has 8MB now), made the
> kernel boot, but ramdisk decompression failed. All in all you will need at
> least 12MB to boot correctly, if you are using a bz2bzImage of about 700kB
> and a 2MB compressed ramdisk image.

Good stuff, but why take this opportunity to make an ugly name even uglier?
How about bz2Image, or, more natural in my mind, bz2linux.

-- 
Daniel
