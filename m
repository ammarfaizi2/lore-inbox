Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264698AbSKDPBU>; Mon, 4 Nov 2002 10:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbSKDPBU>; Mon, 4 Nov 2002 10:01:20 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:27280 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264698AbSKDPBT>; Mon, 4 Nov 2002 10:01:19 -0500
Subject: Re: [lkcd-general] Re: What's left over.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: hps@intermeta.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <aq616a$9da$1@forge.intermeta.de>
References: <Pine.LNX.3.96.1021103082813.5197A-100000@gatekeeper.tmr.com>
	<3DC5DF14.34483A96@compuserve.com>  <aq616a$9da$1@forge.intermeta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Nov 2002 15:29:35 +0000
Message-Id: <1036423775.1113.71.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-04 at 14:45, Henning P. Schmiedehausen wrote:
> Good! This means, people debugging the code have actually to think and
> don't produce "turn on debugger, step here, there, patch a band aid,

Some of us debug hardware. Regardless of the nice theories about
reviewing your code they don't actually work on hardware because no
amount of code review will let you discover things like undocumented 
2uS deskew delays, or errors in DMA engines


