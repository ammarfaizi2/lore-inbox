Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318931AbSHSQas>; Mon, 19 Aug 2002 12:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318932AbSHSQas>; Mon, 19 Aug 2002 12:30:48 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:19192 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318931AbSHSQar>; Mon, 19 Aug 2002 12:30:47 -0400
Subject: Re: Interrupt issue with 2.4.19 vs 2.4.18.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020819155421.GA10726@titan.lahn.de>
References: <3D5D527E.5030607@thirddimension.net> 
	<20020819155421.GA10726@titan.lahn.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 19 Aug 2002 17:35:04 +0100
Message-Id: <1029774904.19375.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My board has a Intel 440GX chipset.  From my understanding these are a 
> bitch to deal with and are littered with bugs.  I've also read that by 

Not bugs. Intel refusal to provide documentation on the IRQ routing for
them

