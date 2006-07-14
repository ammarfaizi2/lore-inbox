Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161220AbWGNQ3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161220AbWGNQ3S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161224AbWGNQ3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:29:18 -0400
Received: from mail.gmx.de ([213.165.64.21]:10652 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161220AbWGNQ3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:29:17 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18-rc1-mm2 (bttv: NULL pointer derefernce)
Date: Fri, 14 Jul 2006 18:30:01 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>, Greg KH <greg@kroah.com>
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
In-Reply-To: <20060713224800.6cbdbf5d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607141830.01858.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 14. July 2006 07:48, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1
>8-rc1/2.6.18-rc1-mm2/

Hi,
just want to inform you that the bug is present in 2.6.18-rc1-mm2 too. 
But I took a better screenshot which should be readable:
http://stud4.tuwien.ac.at/~e0227135/kernel/IMG_5614.JPG

I hope it's useful for you, please let me know if I should test any 
patches!

cheers,
dominik
