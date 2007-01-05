Return-Path: <linux-kernel-owner+w=401wt.eu-S1161143AbXAEQXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161143AbXAEQXI (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 11:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161144AbXAEQXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 11:23:08 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:1479 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161143AbXAEQXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 11:23:06 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.20-rc3-mm1
Date: Fri, 5 Jan 2007 17:23:07 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
References: <20070104220200.ae4e9a46.akpm@osdl.org>
In-Reply-To: <20070104220200.ae4e9a46.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701051723.08112.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

	Doesn't build on my iMac G3 based garage jukebox ;-)

arch/powerpc/kernel/of_platform.c:479: error: unknown field 'multithread_probe' specified in initializer
arch/powerpc/kernel/of_platform.c:479: warning: initialization makes pointer from integer without a cast
make[1]: *** [arch/powerpc/kernel/of_platform.o] Blad 1
make: *** [arch/powerpc/kernel] Blad 2

I guess someone who knows multithread code should take a look at it.

-- 
Regards,

	Mariusz Kozlowski
