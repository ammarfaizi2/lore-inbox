Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316988AbSFFOWS>; Thu, 6 Jun 2002 10:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316989AbSFFOWR>; Thu, 6 Jun 2002 10:22:17 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:18936 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316988AbSFFOWQ>; Thu, 6 Jun 2002 10:22:16 -0400
Subject: Re: Question Regarding "EXTRAVERSION" Specification
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: jlmales@yahoo.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4708.1023368487@ocs3.intra.ocs.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Jun 2002 16:15:00 +0100
Message-Id: <1023376500.22728.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-06-06 at 14:01, Keith Owens wrote:
> kbuild 2.5 enforces the limit, the existing kernel build code does not.
> I sent a patch to Linus four times back in the 2.4.15 days, he
> completely ignored it.  Linus does not care about kernel build
> problems.
> 
> I will dig out the patch and send it to Marcelo.

Please CC me a copy and I'll merge it into -ac in case Marcelo loses it
or doesnt want it before 2.4.19 final

