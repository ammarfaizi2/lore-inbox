Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSFDPfO>; Tue, 4 Jun 2002 11:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314101AbSFDPfN>; Tue, 4 Jun 2002 11:35:13 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:23544 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313202AbSFDPfM>; Tue, 4 Jun 2002 11:35:12 -0400
Subject: Re: linux 2.4.19-preX IDE bugs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Evgeniev <nick@octet.spb.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000901c20bdc$76642360$baefb0d4@nick>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Jun 2002 17:41:03 +0100
Message-Id: <1023208863.6773.156.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-04 at 16:28, Nick Evgeniev wrote: 
> A few days ago I wrote about ide & raid0 bugs in 2.4.19-pre8-ac5 and below
> (plain 2.4.18 just trashes fs in a few hours)... Then I was asked about my
> hardware configuration & then was .... ignored silently. Does it mean that
> nobody cares about ide support in Linux kernel?!

You don't seem to have a paid 24hr response contract with me.

I added it to the collection of IDE oddities I'm looking at. There are
also some promise requested changes due to get merged at the end of this
week. Then we can see where we stand

