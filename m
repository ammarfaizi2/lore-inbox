Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311564AbSDUJaj>; Sun, 21 Apr 2002 05:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311577AbSDUJai>; Sun, 21 Apr 2002 05:30:38 -0400
Received: from mail.scram.de ([195.226.127.117]:64203 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S311564AbSDUJah>;
	Sun, 21 Apr 2002 05:30:37 -0400
Date: Sun, 21 Apr 2002 11:28:36 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@alpha.bocc.de
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: Ian Molton <spyro@armlinux.org>, Russell King <rmk@arm.linux.org.uk>,
        <phillips@bonn-fries.net>, <ebiederm@xmission.com>,
        <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
In-Reply-To: <20020421025654.GE2296@conectiva.com.br>
Message-ID: <Pine.LNX.4.44.0204211123590.18496-100000@alpha.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > We dont allow proprietary modules in the kernel, why should docs be any
> > different?
> 
> The documentation being discussed is not proprietary, it only talks about a non
> essential proprietary tool used now by lots of kernel hackers.

So would Linus accept a document on how to run Linux/390 on hercules (yet 
another proprietary emulator)? This also was a FAQ on the linux-390 
mailing list until the documentation is available on the hercules home 
page...

Developing kernel stuff on 390 without emulator can be much fun as host 
operators tend to get very pissed if the IPL ratio comes near to 1/min ;-)

--jochen



