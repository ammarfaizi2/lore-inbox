Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319153AbSH2NKo>; Thu, 29 Aug 2002 09:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319199AbSH2NKo>; Thu, 29 Aug 2002 09:10:44 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:13563
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319153AbSH2NKn>; Thu, 29 Aug 2002 09:10:43 -0400
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dominik Brodowski <devel@brodo.de>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208281649540.27728-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208281649540.27728-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 29 Aug 2002 11:53:40 +0100
Message-Id: <1030618420.7290.112.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  { min-Hz, max-Hz, policy }
> 

For a few of the processors "event-hz" or similar would be nice. The
Geode supports hardware assisted bursting to full processor speed when
doing SMM, I/O and IRQ handling.

