Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261779AbSI3NEu>; Mon, 30 Sep 2002 09:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261790AbSI3NEu>; Mon, 30 Sep 2002 09:04:50 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:65274 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261779AbSI3NEs>; Mon, 30 Sep 2002 09:04:48 -0400
Subject: Re: NatSemi SCx200 patches for Linux-2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christer Weinigel <christer@weinigel.se>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <87u1k7wt16.fsf@zoo.weinigel.se>
References: <87d6qvyb4c.fsf@zoo.weinigel.se>
	<1033388216.16266.1.camel@irongate.swansea.linux.org.uk> 
	<87u1k7wt16.fsf@zoo.weinigel.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Sep 2002 14:16:50 +0100
Message-Id: <1033391810.16468.53.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now I just have to merge back a few things to the 2.4 code; I found a
> few uglies and want to see if the link order trick works with 2.4.

2.4 relies on it. Even IDE requires the trick works

