Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSGUMUB>; Sun, 21 Jul 2002 08:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSGUMUB>; Sun, 21 Jul 2002 08:20:01 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:25589 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314078AbSGUMUA>; Sun, 21 Jul 2002 08:20:00 -0400
Subject: Re: [PATCH] user frobbable escd file can cause oops
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0207211027400.32636-100000@linux-box.realnet.co.sz>
References: <Pine.LNX.4.44.0207211027400.32636-100000@linux-box.realnet.co.sz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Jul 2002 14:35:16 +0100
Message-Id: <1027258516.17234.87.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 09:29, Zwane Mwaikambo wrote:
> patch applies to 2.4-ac but tested on 2.5.26
> 
> I don't think this breaks any userland apps so If there aren't any 
> objections, Alan, Linus please apply

I made the same change a few -ac patches ago, for the same reason that
some BIOSes are not safe for escd accesses

