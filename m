Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267610AbSLSKt1>; Thu, 19 Dec 2002 05:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267611AbSLSKt1>; Thu, 19 Dec 2002 05:49:27 -0500
Received: from holomorphy.com ([66.224.33.161]:56000 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267610AbSLSKt0>;
	Thu, 19 Dec 2002 05:49:26 -0500
Date: Thu, 19 Dec 2002 02:55:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       David Lang <david.lang@digitalinsight.com>, Robert Love <rml@tech9.net>,
       Till Immanuel Patzschke <tip@inw.de>,
       lse-tech <lse-tech@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 15000+ processes -- poor performance ?!
Message-ID: <20021219105511.GV31800@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alex Tomas <bzzz@tmi.comex.ru>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	David Lang <david.lang@digitalinsight.com>,
	Robert Love <rml@tech9.net>, Till Immanuel Patzschke <tip@inw.de>,
	lse-tech <lse-tech@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <1040262178.855.106.camel@phantasy> <Pine.LNX.4.44.0212181743350.7848-100000@dlang.diginsite.com> <20021219020552.GO31800@holomorphy.com> <200212191015.gBJAFss28329@Port.imtp.ilyichevsk.odessa.ua> <20021219102720.GT31800@holomorphy.com> <m3u1hapa51.fsf@lexa.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3u1hapa51.fsf@lexa.home.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin (WLI) writes:
WLI> As userspace solutions go your suggestions is just as good. The
WLI> kernel still needs to get its act together and with some
WLI> urgency.

On Thu, Dec 19, 2002 at 01:37:30PM +0300, Alex Tomas wrote:
> what about retreiving info from /proc/kmem or something like? just to 
> avoid binary -> text(proc) -> binary

That would also be an excellent userspace solution to this local DoS.


Bill
