Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265094AbSKETcb>; Tue, 5 Nov 2002 14:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265098AbSKETcb>; Tue, 5 Nov 2002 14:32:31 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:48021 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265094AbSKETca>; Tue, 5 Nov 2002 14:32:30 -0500
Subject: Re: CONFIG_TINY
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Tom Rini <trini@kernel.crashing.org>, Rob Landley <landley@trommello.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1021105141149.17410L-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1021105141149.17410L-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 19:59:55 +0000
Message-Id: <1036526395.6750.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 19:26, Bill Davidsen wrote:
> > Then we don't we always use -Os?
> 
> 1 - I'm not sure all versions of gcc support it, as in "it generates
> correct code."

2.95 built with -Os was I believe used by Caldera and turned out faster
code than -O2. For 3.2  -O2 appears faster  {yes I know
microbenchmarking is not the full picture}


