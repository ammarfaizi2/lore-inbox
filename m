Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318650AbSHSXqx>; Mon, 19 Aug 2002 19:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319109AbSHSXqx>; Mon, 19 Aug 2002 19:46:53 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:35577 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318650AbSHSXqw>; Mon, 19 Aug 2002 19:46:52 -0400
Subject: Re: MAX_PID changes in 2.5.31
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ajrsok$p0m$1@cesium.transmeta.com>
References: <200208192236.g7JMaxS28968@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.44.0208200040010.5356-100000@localhost.localdomain>
	<200208192242.g7JMgmD29241@vindaloo.ras.ucalgary.ca> 
	<ajrsok$p0m$1@cesium.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 Aug 2002 00:51:18 +0100
Message-Id: <1029801078.21212.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-19 at 23:51, H. Peter Anvin wrote:
> It probably should change at some point.  I would favour changing the
> default to aggressive in 2.5, to smoke out bugs, and perhaps turn it
> back to conservative in 2.6.  In 2.7, we probably should turn on
> aggressive for good.

By that point I'd hope anyone running large workloads is running a 64bit
CPU not x86_32 8) At which point the problem is mostly moot

