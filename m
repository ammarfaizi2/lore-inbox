Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316832AbSGVLjP>; Mon, 22 Jul 2002 07:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316833AbSGVLjP>; Mon, 22 Jul 2002 07:39:15 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:52221 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316832AbSGVLjO>; Mon, 22 Jul 2002 07:39:14 -0400
Subject: Re: SMP Problem with 2.4.19-rc2 on Asus A7M266-D
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Shirley <dave@cs.curtin.edu.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.1.6.0.20020722111310.0356ed70@pop.cs.curtin.edu.au>
References: <5.1.1.6.0.20020722111310.0356ed70@pop.cs.curtin.edu.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Jul 2002 13:53:32 +0100
Message-Id: <1027342412.31787.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 04:13, David Shirley wrote:
> OK I just put on 2.4.19-rc3 and it works fine, so maybe its something in
> the ac patch?

The -ac patch has the summit SMP work in it. This means it can boot on
the ultra high end cool IBM stuff. It should also boot on the normal SMP
stuff too but in a few cases right now does not.

There are IBM folks looking into this so I've left the problem in my
tree while it gets sorted. Ultimately it does need to be solved for real

