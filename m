Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266839AbUIEQQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266839AbUIEQQr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 12:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266850AbUIEQQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 12:16:47 -0400
Received: from the-village.bc.nu ([81.2.110.252]:2461 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266839AbUIEQQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 12:16:46 -0400
Subject: Re: New proposed DRM interface design
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Keith Whitwell <keith@tungstengraphics.com>, Dave Jones <davej@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mharris@redhat.com
In-Reply-To: <9e47339104090509056e54866e@mail.gmail.com>
References: <20040904102914.B13149@infradead.org>
	 <4139C8A3.6010603@tungstengraphics.com>
	 <9e47339104090408362a356799@mail.gmail.com>
	 <4139FEB4.3080303@tungstengraphics.com>
	 <9e473391040904110354ba2593@mail.gmail.com>
	 <1094386050.1081.33.camel@localhost.localdomain>
	 <9e47339104090508052850b649@mail.gmail.com>
	 <1094393713.1264.7.camel@localhost.localdomain>
	 <9e473391040905083326707923@mail.gmail.com>
	 <1094395462.1271.12.camel@localhost.localdomain>
	 <9e47339104090509056e54866e@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094397179.1269.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 05 Sep 2004 16:13:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-09-05 at 17:05, Jon Smirl wrote:
> They have to be merged. Cards with two heads need the mode set on each
> head. fbdev only sets the mode on one head. If I teach fbdev how to
> set the mode of the other head fbdev needs to learn about memory
> management.  The DRM memory management code is complex and is a big
> chunk of the driver.

I see the entire time at OLS trying to sort this out was a complete
waste.

