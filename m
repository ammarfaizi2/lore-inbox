Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269911AbSISEik>; Thu, 19 Sep 2002 00:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269918AbSISEik>; Thu, 19 Sep 2002 00:38:40 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:42249 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S269911AbSISEik>;
	Thu, 19 Sep 2002 00:38:40 -0400
Date: Thu, 19 Sep 2002 06:43:10 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alexander Hoogerhuis <alexh@ihatent.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre7-ac2 compile and IrDA
Message-ID: <20020919044310.GA13899@alpha.home.local>
References: <200209190222.33276.duncan.sands@math.u-psud.fr> <3D891BD1.8F774946@digeo.com> <m3bs6uyerj.fsf_-_@lapper.ihatent.com> <1032398756.24835.29.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1032398756.24835.29.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 02:25:56AM +0100, Alan Cox wrote:
> > gcc -D__KERNEL__ -I/home/alexh/src/linux/linux-2.4-ac-test/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
                                             ^^^^^^^^^^^
> What architecture - its defined for x86 definitely

=> he seems to be on x86 too.

Cheers,
Willy
