Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318253AbSG3MtT>; Tue, 30 Jul 2002 08:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318254AbSG3MtT>; Tue, 30 Jul 2002 08:49:19 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:25341 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318253AbSG3MtS>; Tue, 30 Jul 2002 08:49:18 -0400
Subject: Re: Tyan K7X with AMD MP 2.4.19-rc3-ac4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Mierau <tmi@wikon.de>
Cc: linux-kernel@vger.kernel.org, thomas@mierau.org
In-Reply-To: <200207301421.18701.tmi@wikon.de>
References: <200207301421.18701.tmi@wikon.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 Jul 2002 15:08:49 +0100
Message-Id: <1028038129.6725.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-30 at 13:21, Thomas Mierau wrote:
> Hi
> 
> I am trying to get the above board to work. Somehow it doesn't.
> I tried kernel  2.4.18, 2.4.19-rc3, 2.4.19-rc3-ac3 and of course the latest 
> 2.4.19-rc3-ac4
> 
> The machine itself is "working" stable under 2.4.18 with a limited 
> functionality (no network, no additional scsi ports, no printer, no usb ...)

Start by disabling acpi support

