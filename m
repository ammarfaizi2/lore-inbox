Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWHBP7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWHBP7Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 11:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWHBP7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 11:59:25 -0400
Received: from mail.gmx.net ([213.165.64.21]:6822 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932068AbWHBP7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 11:59:24 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.18-rc1-mm2 and 2.6.18-rc3 (bttv: NULL pointer derefernce)
Date: Wed, 2 Aug 2006 18:00:23 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>, Greg KH <greg@kroah.com>
References: <20060713224800.6cbdbf5d.akpm@osdl.org> <200607141830.01858.dominik.karall@gmx.net>
In-Reply-To: <200607141830.01858.dominik.karall@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608021800.23905.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

I'm not sure if anybody is working on this bug (see below), but as it 
happens with 2.6.18-rc3 too, I think it's important to inform you to 
avoid that this bug hits the final release.

thx,
dominik

On Friday, 14. July 2006 18:30, Dominik Karall wrote:
> On Friday, 14. July 2006 07:48, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6
> >.1 8-rc1/2.6.18-rc1-mm2/
>
> Hi,
> just want to inform you that the bug is present in 2.6.18-rc1-mm2
> too. But I took a better screenshot which should be readable:
> http://stud4.tuwien.ac.at/~e0227135/kernel/IMG_5614.JPG
>
> I hope it's useful for you, please let me know if I should test any
> patches!
>
> cheers,
> dominik
