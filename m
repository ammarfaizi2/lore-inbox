Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318116AbSG2XSV>; Mon, 29 Jul 2002 19:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318128AbSG2XSV>; Mon, 29 Jul 2002 19:18:21 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:1788 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318116AbSG2XSU>; Mon, 29 Jul 2002 19:18:20 -0400
Subject: Re: Linux 2.4.19-rc3 (hyperthreading)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Theurer <habanero@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <200207291558.47266.habanero@us.ibm.com>
References: <200207291454.30076.habanero@us.ibm.com>
	<1027978122.4050.22.camel@irongate.swansea.linux.org.uk> 
	<200207291558.47266.habanero@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 Jul 2002 01:37:25 +0100
Message-Id: <1027989445.4050.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 21:58, Andrew Theurer wrote:
> Agreed, we need some sort of irqbalance, and I intend to test with Ingo's and 
> Andrea's approaches. With that addition, I may even see an improvement with 
> hyperthreading. But for an rc release, I think it would be prudent to revert 
> the "new code" for default hyperthreading behavior, and attack the whole 
> problem in 2.4.20 or later release.

Because your personal workload is slower ?

Thats overkill to say the least. Learn to use the kernel boot options

