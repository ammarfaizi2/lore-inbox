Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314321AbSEBKSx>; Thu, 2 May 2002 06:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314327AbSEBKSw>; Thu, 2 May 2002 06:18:52 -0400
Received: from zeus.kernel.org ([204.152.189.113]:13206 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S314321AbSEBKSw>;
	Thu, 2 May 2002 06:18:52 -0400
Message-Id: <200205021014.g42AEmX06448@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Date: Thu, 2 May 2002 13:17:56 -0200
X-Mailer: KMail [version 1.3.2]
Cc: torvalds@transmeta.com
In-Reply-To: <20507.1020263013@ocs3.intra.ocs.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 May 2002 12:23, Keith Owens wrote:
> Linus, kbuild 2.5 is ready for inclusion in the main 2.5 kernel tree.
> It is faster, better documented, easier to write build rules in, has
> better install facilities, allows separate source and object trees, can
> do concurrent builds from the same source tree and is significantly
> more accurate than the existing kernel build system.

I never used kbuild 2.5 (sorry Keith), but I am tired of
'make mrproper' bug in existing kernel build system.
Whenever my new kernel does not boot, I have to do
full build just to make sure I wasn't bitten
by it again.

I gather there is no such bug in kbuild 2.5.
That's good.
--
vda
