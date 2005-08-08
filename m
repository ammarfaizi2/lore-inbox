Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVHHGxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVHHGxd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 02:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVHHGxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 02:53:33 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:62393 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750726AbVHHGxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 02:53:33 -0400
Date: Mon, 8 Aug 2005 08:53:09 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Martin Loschwitz <madkiss@madkiss.org>
cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: local DDOS? Kernel panic when accessing /proc/ioports
In-Reply-To: <20050805214954.GA25533@minerva.local.lan>
Message-ID: <Pine.LNX.4.61.0508080851120.18088@yvahk01.tjqt.qr>
References: <20050805192628.GA24706@minerva.local.lan>
 <Pine.LNX.4.61.0508051538390.6245@chaos.analogic.com>
 <20050805214954.GA25533@minerva.local.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>> I just ran into the following problem: Having updated my box to 2.6.12.3,
>>> I tried to start YaST2 and noticed a kernel panic (see below). Some quick

Hm I always have a slack feeling that vanilla does not play hand in hand with 
SUSE. (E.g.: showconsole)

>>> Ooops and ksymoops-output is attached.

ksymoops not needed for 2.6.

>> Been there, done that.

"...[and] threw it out"



Jan Engelhardt
-- 
