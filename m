Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbTILUcn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 16:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTILUcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 16:32:43 -0400
Received: from vlugnet.org ([217.160.107.28]:2476 "EHLO vlugnet.org")
	by vger.kernel.org with ESMTP id S261889AbTILUcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 16:32:42 -0400
From: Ronny Buchmann <ronny-lkml@vlugnet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [OOPS] 2.4.22 / HPT372N
Date: Fri, 12 Sep 2003 22:32:32 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, Marko Kreen <marko@l-t.ee>
References: <200309091406.56334.ronny-lkml@vlugnet.org> <20030911123418.GA6798@l-t.ee> <200309121141.45776.ronny-lkml@vlugnet.org>
In-Reply-To: <200309121141.45776.ronny-lkml@vlugnet.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200309122231.43519.ronny-lkml@vlugnet.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 12. September 2003 11:41 schrieb Ronny Buchmann:
> > I replaced "< 0x55" with "<= 0x55" in hpt366.c and the driver
> > did not crash, but it also did not detect cdrom - only thing
> > behind it ATM - so I did not bother messing with it further.
>
> I will test with cdrom attached later today.
> Currently I have one disk on each channel.
tested with cdrom, works

-- 
ronny

