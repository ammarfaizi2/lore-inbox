Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319605AbSH2XR4>; Thu, 29 Aug 2002 19:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319599AbSH2XR4>; Thu, 29 Aug 2002 19:17:56 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:38141
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319596AbSH2XRy>; Thu, 29 Aug 2002 19:17:54 -0400
Subject: Re: ide-2.4.20-pre4-ac2.patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208300113150.8911-100000@serv>
References: <Pine.LNX.4.44.0208300113150.8911-100000@serv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 30 Aug 2002 00:21:04 +0100
Message-Id: <1030663264.1327.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-30 at 00:16, Roman Zippel wrote:
> Hi,
> 
> On 29 Aug 2002, Alan Cox wrote:
> 
> > Gayle I think should be m68k
> > not ppc (actually Im pretty sure),
> 
> It's for m68k and ppc Amigas, but I don't think two separate drivers are
> needed.

So its actually a false divide and dumping them in "legacy" is probably
a lot simpler ?

