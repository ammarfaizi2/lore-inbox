Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135743AbRD2Ljt>; Sun, 29 Apr 2001 07:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135742AbRD2Ljj>; Sun, 29 Apr 2001 07:39:39 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:18692 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S135739AbRD2Lj1>;
	Sun, 29 Apr 2001 07:39:27 -0400
Date: Fri, 27 Apr 2001 11:32:09 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Andre M. Hedrick" <andre@suse.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SysRq
Message-ID: <20010427113209.C37@(none)>
In-Reply-To: <200104261925.VAA15706@green.mif.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200104261925.VAA15706@green.mif.pg.gda.pl>; from ankry@green.mif.pg.gda.pl on Thu, Apr 26, 2001 at 09:25:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    The following patch add more disk devices to the SysRq sync list (in both:
> -pre and -ac trees). Were the extra IDE devices intentionally omitted here?

No, ommiting them was probably bug.

> BTW, it would be probably nice to add some mon-x86 disk devices here...

True... Feel free to do so.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

