Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135586AbRDSICY>; Thu, 19 Apr 2001 04:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135587AbRDSICO>; Thu, 19 Apr 2001 04:02:14 -0400
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:3851 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S135586AbRDSICI>; Thu, 19 Apr 2001 04:02:08 -0400
Date: Thu, 19 Apr 2001 09:02:03 +0100 (BST)
From: Steve Hill <steve@navaho.co.uk>
To: TroyBenjegerdes <hozer@drgw.net>
cc: TorreyHoffman <torrey.hoffman@myrio.com>, linux-kernel@vger.kernel.org
Subject: Re: An improved natsemi driver for 2.2
In-Reply-To: <20010418234719.B20259@altus.drgw.net>
Message-ID: <Pine.LNX.4.21.0104190856020.1278-100000@sorbus.navaho>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2001, TroyBenjegerdes wrote:

> Well, on kernel 2.2.19 on a 'regular' PC box (celeron 533), it works
> better than the 1.07b version from scyld.com, but it still gets tripped up
> pretty bad by nfs traffic. (Have you tried NFS on your board at all?). It

Not tried NFS yet...  Although, using the patch that I posted, everything
seems to work ok and then occasionally I get a big slow down - I haven't
had time to look to see what this is (it may even be something completely
unrelated like the kernel flushing buffers to disk)...  I'll hopefully
test it sometime this week.

-- 

- Steve Hill
System Administrator         Email: steve@navaho.co.uk
Navaho Technologies Ltd.       Tel: +44-870-7034015

        ... Alcohol and calculus don't mix - Don't drink and derive! ...


