Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271370AbRIJQh1>; Mon, 10 Sep 2001 12:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271399AbRIJQhR>; Mon, 10 Sep 2001 12:37:17 -0400
Received: from fly.HiWAAY.net ([208.147.154.56]:11527 "EHLO mail.hiwaay.net")
	by vger.kernel.org with ESMTP id <S271370AbRIJQhA>;
	Mon, 10 Sep 2001 12:37:00 -0400
Date: Mon, 10 Sep 2001 11:37:22 -0500
From: Chris Adams <cmadams@hiwaay.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Software RAID-1 Oops on Alpha on 2.4.x kernels
Message-ID: <20010910113722.A14884@HiWAAY.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Newsgroups: fa.linux.kernel
In-Reply-To: <fa.kl7uv5v.pj85iq@ifi.uio.no>
Organization: HiWAAY Internet Services
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, Dustin Marquess  <jailbird@alcatraz.fdf.net> said:
>I've been trying to upgrade the kernel on one of my Alphas running
>Software RAID-1 from 2.2.19 to any 2.4.x kernel all weekend.  I've tried
>everything from 2.4.5 to 2.4.10-pre7, and all of them Oops.  They either
>Oops when I run mke2fs or mkreiserfs on the md device, or when I mount the
>md drvice, or if I get it mounted and start copying files over to it.

All I can say is that I had this problem on Alpha with RAID 1 on every
2.4 kernel I tried as well.  I was trying to use an older spare Alpha to
upgrade a server; in the end, I gave up and bought a new x86 box. :-(
-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
