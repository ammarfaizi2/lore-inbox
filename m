Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbSIZPC1>; Thu, 26 Sep 2002 11:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbSIZPC1>; Thu, 26 Sep 2002 11:02:27 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:19193
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261354AbSIZPC0>; Thu, 26 Sep 2002 11:02:26 -0400
Subject: Re: [BUG] apm resume hangs on IBM T22 with 2.4.19 (harddrive sleeps
	forever)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Karel Gardas <kgardas@objectsecurity.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.43.0209251253050.652-200000@thinkpad.objectsecurity.cz>
References: <Pine.LNX.4.43.0209251253050.652-200000@thinkpad.objectsecurity.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Sep 2002 16:12:43 +0100
Message-Id: <1033053163.11848.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have problem with resume from suspend on IBM T22 with kernel 2.4.19
> patched with rmap-14a and usagi-20020916. Actually the problem is that OS
> resume well from suspend (it prints some messages to console for example

Make sure your bios and other firmware are reasonably modern

