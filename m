Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318861AbSHLWqF>; Mon, 12 Aug 2002 18:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318859AbSHLWqF>; Mon, 12 Aug 2002 18:46:05 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:18674 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318861AbSHLWqE>; Mon, 12 Aug 2002 18:46:04 -0400
Subject: Re: Ipaq 39xx
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hans-Christian Armingeon <linux.johnny@gmx.net>
Cc: Ian Molton <spyro@f2s.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200208130030.33417.linux.johnny@gmx.net>
References: <20020812225326.2ef976b8.spyro@f2s.com> 
	<200208130030.33417.linux.johnny@gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Aug 2002 23:47:15 +0100
Message-Id: <1029192435.20980.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-12 at 23:30, Hans-Christian Armingeon wrote:
> But stay away from Xscale, it is like the P4: optimized for MHz, not for instructions per clock.

Which eventually does pay off (at 2.4GHz the PIV is finally beating
AMD). The problem with the Xscale right now is some of the errata
cripple the performance when running with an MMU enabled. Until they are
resolved the xscale isnt going to fly.


