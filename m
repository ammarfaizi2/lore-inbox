Return-Path: <linux-kernel-owner+w=401wt.eu-S1422661AbXAESp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422661AbXAESp1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 13:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422663AbXAESp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 13:45:27 -0500
Received: from [139.30.44.16] ([139.30.44.16]:1380 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1422661AbXAESp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 13:45:26 -0500
Date: Fri, 5 Jan 2007 19:45:25 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: 2.6.20-rc3-mm1
In-Reply-To: <200701051723.08112.m.kozlowski@tuxland.pl>
Message-ID: <Pine.LNX.4.63.0701051944490.21110@gockel.physik3.uni-rostock.de>
References: <20070104220200.ae4e9a46.akpm@osdl.org> <200701051723.08112.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2007, Mariusz Kozlowski wrote:

> 	Doesn't build on my iMac G3 based garage jukebox ;-)
> 
> arch/powerpc/kernel/of_platform.c:479: error: unknown field 'multithread_probe' specified in initializer
> arch/powerpc/kernel/of_platform.c:479: warning: initialization makes pointer from integer without a cast
> make[1]: *** [arch/powerpc/kernel/of_platform.o] Blad 1
> make: *** [arch/powerpc/kernel] Blad 2

Can you please post your .config?

Thanks,
Tim
