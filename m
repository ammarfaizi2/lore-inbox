Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318246AbSHZUS4>; Mon, 26 Aug 2002 16:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318250AbSHZUSz>; Mon, 26 Aug 2002 16:18:55 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:14846 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318246AbSHZUSz>; Mon, 26 Aug 2002 16:18:55 -0400
Subject: Re: [PATCH] tsc-disable_B9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Pavel Machek <pavel@elf.ucw.cz>, Andrea Arcangeli <andrea@suse.de>,
       Mikael Pettersson <mikpe@csd.uu.se>, john stultz <johnstul@us.ibm.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
In-Reply-To: <Pine.LNX.3.95.1020826151445.6296A-100000@chaos.analogic.com>
References: <Pine.LNX.3.95.1020826151445.6296A-100000@chaos.analogic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 26 Aug 2002 21:23:43 +0100
Message-Id: <1030393423.2776.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-26 at 20:18, Richard B. Johnson wrote:

> The CPU counters are synchronized on SMP machines. How can you
> ever get negative time? Even GHz machines take several months
> to wrap the count.

On a typical intel chipset PC maybe, on anything fancy - nope. Not even
on a 440BX board with mixed speed processors

