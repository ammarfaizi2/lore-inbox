Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318325AbSHUO5N>; Wed, 21 Aug 2002 10:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318332AbSHUO5N>; Wed, 21 Aug 2002 10:57:13 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:52718 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318325AbSHUO5N>; Wed, 21 Aug 2002 10:57:13 -0400
Subject: Re: [PATCH] tsc-disable_B9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, john stultz <johnstul@us.ibm.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
In-Reply-To: <20020821143323.GF1117@dualathlon.random>
References: <1028771615.22918.188.camel@cog>
	<1028812663.28883.32.camel@irongate.swansea.linux.org.uk>
	<1028860246.1117.34.camel@cog> <20020815165617.GE14394@dualathlon.random>
	<1029496559.31487.48.camel@irongate.swansea.linux.org.uk>
	<15708.64483.439939.850493@kim.it.uu.se>
	<20020821131223.GB1117@dualathlon.random>
	<1029939024.26425.49.camel@irongate.swansea.linux.org.uk> 
	<20020821143323.GF1117@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Aug 2002 16:01:55 +0100
Message-Id: <1029942115.26411.81.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 15:33, Andrea Arcangeli wrote:
> But silenty breaking apps and not allowing in any way to apps to learn
> if the tsc is returning random or if it's returning something
> significant (I understand that's the way you did it in -ac) is a no-way
> by default IMHO.

All such apps and libraries are already broken have been silently broken
since about 1999 and will continue to be broken. Thats been true since
speedstep cpus appeared if not before.

Alan

