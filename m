Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbSLQIrW>; Tue, 17 Dec 2002 03:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbSLQIrW>; Tue, 17 Dec 2002 03:47:22 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:52751
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S261330AbSLQIrV>; Tue, 17 Dec 2002 03:47:21 -0500
Date: Tue, 17 Dec 2002 00:52:44 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: edward.kuns@rockwellfirstpoint.com, linux-kernel@vger.kernel.org
Subject: Re: i845PE chipset and 20276 Promise Controller boot failure with
 2.4.20-ac2
In-Reply-To: <200212170646.gBH6kCs16053@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.10.10212170051360.31876-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2002, Denis Vlasenko wrote:

> On 16 December 2002 21:09, edward.kuns@rockwellfirstpoint.com wrote:
> > acted exactly the same.  So then I added a bunch of printk's to see
> > if I could localize where it was hanging and it died immediately
> > after displaying info about the PIIX driver.
> 
> Way to go man! This will save tons of time for IDE folks if everyone
> who has problems go that far in debugging.
> If you'll play with printk a bit more, you will find it.

Really I am now curious as to when it first showed up.
This i845 has been a royal pain!

Andre Hedrick
LAD Storage Consulting Group

