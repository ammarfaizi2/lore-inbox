Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbSKUARv>; Wed, 20 Nov 2002 19:17:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265063AbSKUARu>; Wed, 20 Nov 2002 19:17:50 -0500
Received: from rth.ninka.net ([216.101.162.244]:12934 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S263544AbSKUARu>;
	Wed, 20 Nov 2002 19:17:50 -0500
Subject: Re: Linux 2.2.23-rc2
From: "David S. Miller" <davem@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Florian Weimer <fw@deneb.enyo.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1037837993.3702.106.camel@irongate.swansea.linux.org.uk>
References: <200211201628.gAKGSwL03853@devserv.devel.redhat.com> 
	<87wun796m3.fsf@deneb.enyo.de> 
	<1037837993.3702.106.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Nov 2002 16:44:50 -0800
Message-Id: <1037839490.15694.0.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 16:19, Alan Cox wrote:
> > But doesn't seem to include the TCP "SYN with RST isn't a SYN, really"
> > fix. ;-)
> 
> I wasnt aware 2.2 had that problem. I'll take a look.

It doesn't.

Only >= 2.4.x had that bug.

