Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268849AbUIMSvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268849AbUIMSvh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 14:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268870AbUIMSvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 14:51:36 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:61914 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268849AbUIMSvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 14:51:00 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: radeon-pre-2
Date: Mon, 13 Sep 2004 11:49:25 -0700
User-Agent: KMail/1.7
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@linux.ie>,
       Felix =?iso-8859-1?q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de> <1095093816.14586.51.camel@localhost.localdomain> <9e473391040913111158292add@mail.gmail.com>
In-Reply-To: <9e473391040913111158292add@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409131149.25231.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 13, 2004 11:11 am, Jon Smirl wrote:
> The IA64 people want a file/ioctl interface on the /dev/vga0 devices
> so that they can issue control calls to the active device in each "VGA
> space"

I think ppc and sparc want this too, we'll use it for issuing legacy in/out.

Thanks,
Jesse
