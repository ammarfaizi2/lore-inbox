Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267930AbUH3Bd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267930AbUH3Bd0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 21:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268405AbUH3Bd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 21:33:26 -0400
Received: from gepard.lm.pl ([212.244.46.42]:46559 "EHLO gepard.lm.pl")
	by vger.kernel.org with ESMTP id S267930AbUH3BdZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 21:33:25 -0400
Subject: Re: 2.6.9-rc1-mm1 kernel BUG at fs/jbd/checkpoint.c:646!
From: Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040829155734.0e47e6e0.akpm@osdl.org>
References: <1093732735.1866.2.camel@rakieeta>
	 <20040829155734.0e47e6e0.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-2
Organization: o2.pl Sp z o.o.
Message-Id: <1093829523.1888.0.camel@rakieeta>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 30 Aug 2004 03:32:03 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W li¶cie z pon, 30-08-2004, godz. 00:57, Andrew Morton pisze: 
> Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl> wrote:
> >
> > this keeps happening on the SMP highmem box under heavy sync IO load.
> > 
> >  kernel BUG at fs/jbd/checkpoint.c:646!
> 
> Are you using the data=journal mount option?

Yes, I am.

Krzysztof.

