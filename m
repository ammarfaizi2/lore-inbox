Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267139AbSLaEPk>; Mon, 30 Dec 2002 23:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267142AbSLaEPk>; Mon, 30 Dec 2002 23:15:40 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:32418 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267139AbSLaEPj> convert rfc822-to-8bit; Mon, 30 Dec 2002 23:15:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: Nathaniel Russell <reddog83@chartermi.net>, <alan@redhat.com>
Subject: Re: [PATCH][2.4-ac] VT8633 GART Support [RESEND] Corrected
Date: Tue, 31 Dec 2002 05:23:57 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0212311106220.995-200000@reddog.example.net>
In-Reply-To: <Pine.LNX.4.44.0212311106220.995-200000@reddog.example.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212310523.43390.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 December 2002 17:18, Nathaniel Russell wrote:

Hi Nathaniel,

> The first patch i sent to the list was wroung becaue i miss typed out the
> PCI_DEVICE... it was supposed to be PCI_DEVICE_ID_VIA_8633_0 pci id is
> 0x3091
> Well here is the complete fixed and correct version of my patch.
> I'm sorry about all the hassle.
> Please apply the corrected patch to 2.4.20-ac2
> Marc it should complete compile this time around, that is really weird,
> Thank you though.
> Nathaniel
> CC me at reddog83@chartermi.net
shouldn't this be exactly 8633_1 ? Assuming this is a AGP patch and: 
http://pciids.sourceforge.net/iii/?m=1&i=1106b091

tells the same, 8633_1 :)

ciao, Marc
