Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317424AbSGIVpL>; Tue, 9 Jul 2002 17:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317429AbSGIVpK>; Tue, 9 Jul 2002 17:45:10 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:16885 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S317424AbSGIVpJ>; Tue, 9 Jul 2002 17:45:09 -0400
Subject: Re: BKL removal
From: Robert Love <rml@mvista.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Rick Lindsley <ricklind@us.ibm.com>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D2AF6EA.1030008@us.ibm.com>
References: <20020709201703.GC27999@kroah.com>	<200207092055.g69Ktt418608@eng4.beaverton
	 .ibm.com>
	<20020709210053.GF25360@holomorphy.com>	<1026249175.1033.1178.camel@sinai>
	<3D2AF10A.1020603@us.ibm.com> <1026250151.1623.1185.camel@sinai> 
	<3D2AF6EA.1030008@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Jul 2002 14:47:49 -0700
Message-Id: <1026251269.5516.1187.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-09 at 07:44, Dave Hansen wrote:

> The Stanford Checker or something resembling it would be invaluable 
> here.  It would be a hell of a lot better than my litle patch!

The Stanford Checker would be infinitely invaluable here -- agreed.

Anything that can graph call chains and do analysis... we can get it to
tell us exactly who and what.

	Robert Love

