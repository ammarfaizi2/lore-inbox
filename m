Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264614AbSLBP2z>; Mon, 2 Dec 2002 10:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264624AbSLBP2z>; Mon, 2 Dec 2002 10:28:55 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:18590 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264614AbSLBP2x>; Mon, 2 Dec 2002 10:28:53 -0500
Subject: Re: PROBLEM: sound is stutter, sizzle with lasts kernel releases
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: xizard@enib.fr
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DEAA660.60004@enib.fr>
References: <3DEA322B.40204@enib.fr>
	<1038765233.30392.0.camel@irongate.swansea.linux.org.uk> 
	<3DEAA660.60004@enib.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Dec 2002 16:09:53 +0000
Message-Id: <1038845393.1020.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-02 at 00:16, XI wrote:
> I was thinking about a problem with my chipset (AMD760MPX, motherboard 
> tyan tiger MPX); because I have done some tests on a PC with a matrox 
> G200 PCI and a sound blaster live, with a chipset via KT333 and the 
> problem doesn't seems to occur. Is it possible?

Could be - the newer kernel supports IDE DMA, and in my experience the
AMD76x has serious fairness problems (I gave up using it for video
capture)

