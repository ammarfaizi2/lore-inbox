Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267516AbTAXDIM>; Thu, 23 Jan 2003 22:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267513AbTAXDIM>; Thu, 23 Jan 2003 22:08:12 -0500
Received: from rth.ninka.net ([216.101.162.244]:46247 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S267510AbTAXDIL>;
	Thu, 23 Jan 2003 22:08:11 -0500
Subject: Re: Aic7xxx 6.2.28 and Aic79xx 1.3.0 Released
From: "David S. Miller" <davem@redhat.com>
To: "Justin T. Gibbs" <gibbs@btc.adaptec.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <87730000.1043275833@aslan.btc.adaptec.com>
References: <87730000.1043275833@aslan.btc.adaptec.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Jan 2003 19:55:46 -0800
Message-Id: <1043380546.16483.6.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-22 at 14:50, Justin T. Gibbs wrote:
> GNU patch relative to 2.5.59:
>  http://people.FreeBSD.org/~gibbs/linux/SRC/aic79xx-linux-2.5.59-20030122-gnupatch.gz

Justin, I haven't checked, but have you deleted my change
again to include asm/io.h in aix7xxx_osm.h?

You keep doing this, I wish you'd stop :-)

More seriously, you really need to look at the build etc.
fixes people put into your driver in 2.5.x, it is rude to
keep deleting such changes over and over again.

