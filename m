Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317354AbSILUiC>; Thu, 12 Sep 2002 16:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317355AbSILUiC>; Thu, 12 Sep 2002 16:38:02 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:4856 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317354AbSILUiB>; Thu, 12 Sep 2002 16:38:01 -0400
Subject: Re: AMD 760MPX DMA lockup (partly solved)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       kernel@street-vision.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020912211452.C29717@fi.muni.cz>
References: <20020912161258.A9056@fi.muni.cz>
	<200209121815.g8CIFdp06612@Port.imtp.ilyichevsk.odessa.ua> 
	<20020912211452.C29717@fi.muni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 12 Sep 2002 21:43:12 +0100
Message-Id: <1031863392.2902.113.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-12 at 20:14, Jan Kasprzak wrote:
> 	I the bug got merged from the -ac kernels, because it is
> present bot in the kernel 2.4.19-11 from RedHat "null" beta
> and in 2.4.20-pre2-ac1 (altough the later crashes instead of lock-up).

That would strange actually. The Red Hat beta kernel has 2.4.18 like IDE
not -ac like IDE


