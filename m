Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264724AbSLQGoF>; Tue, 17 Dec 2002 01:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264733AbSLQGoF>; Tue, 17 Dec 2002 01:44:05 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:11785 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S264724AbSLQGoE>; Tue, 17 Dec 2002 01:44:04 -0500
Message-Id: <200212170646.gBH6kCs16053@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: edward.kuns@rockwellfirstpoint.com, linux-kernel@vger.kernel.org
Subject: Re: i845PE chipset and 20276 Promise Controller boot failure with 2.4.20-ac2
Date: Tue, 17 Dec 2002 09:35:29 -0200
X-Mailer: KMail [version 1.3.2]
Cc: edward.kuns@rockwellfirstpoint.com
References: <OF4D4BDDD2.8FD534AB-ON86256C91.007B9286-86256C91.007EE995@rockwellfirstpoint.com>
In-Reply-To: <OF4D4BDDD2.8FD534AB-ON86256C91.007B9286-86256C91.007EE995@rockwellfirstpoint.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 December 2002 21:09, edward.kuns@rockwellfirstpoint.com wrote:
> acted exactly the same.  So then I added a bunch of printk's to see
> if I could localize where it was hanging and it died immediately
> after displaying info about the PIIX driver.

Way to go man! This will save tons of time for IDE folks if everyone
who has problems go that far in debugging.
If you'll play with printk a bit more, you will find it.
--
vda
