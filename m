Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275990AbRJaATP>; Tue, 30 Oct 2001 19:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277001AbRJaATG>; Tue, 30 Oct 2001 19:19:06 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:266 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275990AbRJaAS5>; Tue, 30 Oct 2001 19:18:57 -0500
Subject: Re: Module Licensing?
To: ttabi@interactivesi.com (Timur Tabi)
Date: Wed, 31 Oct 2001 00:25:53 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3BDF423D.1060503@interactivesi.com> from "Timur Tabi" at Oct 30, 2001 06:13:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15yjCb-0001q7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ah, but what happens if I distribute the source code, the closed-source .o 
> files, and a makefile, and tell people that they should link it?  Am I 
> violating the GPL, or is the end-user?

I am told by legal people you are, because you provided the code soley with
the intent that it was used that way. Whether an imaginative lawyer can
also get you locked away under the DMCA for distributing a device for
violating copyright I dont know 8)

It is actually all very simple in legal terms. The legal terminology is
"derivative work" and basically if its a derivative work of a GPL work its
GPL if not it isnt. Thats what "linking" is about - not /bin/ld.

If you wanted to provide a mixed source/binary driver that wasnt derivative
of the kernel (and there are lots of reasons for it) - don't GPL your 
open source bit use something like MPL or BSD

[I am not a laywer ...]

Alan

