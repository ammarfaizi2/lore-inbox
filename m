Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317359AbSHGPE1>; Wed, 7 Aug 2002 11:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317371AbSHGPE1>; Wed, 7 Aug 2002 11:04:27 -0400
Received: from p50887B26.dip.t-dialin.net ([80.136.123.38]:16862 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317359AbSHGPE0>; Wed, 7 Aug 2002 11:04:26 -0400
Date: Wed, 7 Aug 2002 09:08:00 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: DevilKin <devilkin-lkml@blindguardian.org>
cc: Chris Chabot <chabotc@xs4all.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: Why 'mrproper'?
In-Reply-To: <200208071558.51884.devilkin-lkml@blindguardian.org>
Message-ID: <Pine.LNX.4.44.0208070905360.10270-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 7 Aug 2002, DevilKin wrote:
> LOL. And to add to this, here in Belgium where I live, we have a product
> that is actually called 'Mr. Proper' and it is a cleaning agent.

IIRC this product is german, actually. From Henkel, I believe, but I might 
be wrong. It was named after this product. But that was not the question, 
actually.

'mrproper' will remove most of your objects, configuration, flags, etc.  
However, 'distclean' will firstly make 'mrproper', then remove your backup 
files such as "*~", "*.orig", "*.rej", etc. It's all in the Makefile, 
actually.

			Thunder
-- 
.-../../-./..-/-..- .-./..-/.-.././.../.-.-.-

