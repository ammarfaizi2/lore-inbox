Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317571AbSHYUiR>; Sun, 25 Aug 2002 16:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317580AbSHYUiR>; Sun, 25 Aug 2002 16:38:17 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:16633 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317571AbSHYUiQ>; Sun, 25 Aug 2002 16:38:16 -0400
Subject: Re: packet re-ordering on SMP machines.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3D690D10.5040601@candelatech.com>
References: <3D6884BC.5090004@candelatech.com>
	<1030286473.16651.7.camel@irongate.swansea.linux.org.uk> 
	<3D690D10.5040601@candelatech.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 25 Aug 2002 21:44:04 +0100
Message-Id: <1030308244.16767.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-25 at 18:00, Ben Greear wrote:
> I would like to detect the number of pkts that such backbone hardware does
> re-order, so if my end machine is also re-ordering, I cannot get valid
> numbers.

Good point 

