Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267631AbSLSKmw>; Thu, 19 Dec 2002 05:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267632AbSLSKmv>; Thu, 19 Dec 2002 05:42:51 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:60420 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267631AbSLSKmv>; Thu, 19 Dec 2002 05:42:51 -0500
Message-Id: <200212191024.gBJAOqs28377@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andre Hedrick <andre@linux-ide.org>
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133  Promise ctrlr, or...
Date: Thu, 19 Dec 2002 13:14:01 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "D.A.M. Revok" <marvin@synapse.net>,
       Manish Lachwani <manish@Zambeel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.10.10212190217240.8350-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10212190217240.8350-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 December 2002 08:19, Andre Hedrick wrote:
> Promise knows this point.
> Thus they moved the setting to a push/pull in the vendor space in the
> dma_base+1 and dma_base+3 respectively.
> lspci -vvvxxx fails when the content is located in bar4 io space.

Neither I nor original bug reporter (I think) did understand
a bit what you said. Can we plead for IDE -> English translation?
;)
If lspci is of no help, what can we use instead?
--
vda
