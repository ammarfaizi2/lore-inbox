Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129164AbRCKVCB>; Sun, 11 Mar 2001 16:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129166AbRCKVBk>; Sun, 11 Mar 2001 16:01:40 -0500
Received: from bart.one-2-one.net ([195.94.80.12]:64772 "EHLO
	bart.one-2-one.net") by vger.kernel.org with ESMTP
	id <S129164AbRCKVBX>; Sun, 11 Mar 2001 16:01:23 -0500
Date: Sun, 11 Mar 2001 22:02:11 +0100 (CET)
From: Martin Diehl <home@mdiehl.de>
To: "W. Michael Petullo" <mike@flyn.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: broken(?) Lucent Venus chipset and Linux 2.4
In-Reply-To: <20010309154032.A1154@dragon.flyn.org>
Message-ID: <Pine.LNX.4.21.0103111239500.10784-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2001, W. Michael Petullo wrote:

> If you have or have access to a Linux box with a Venus-based modem,
> answering any of these questions would be very helpful:
> 

Well, I'm not absolutely sure if we are talking about the same thing: what 
I have is a re-labeled PC-Card modem which identifies according to

cardctl ident:
  product info: "LUCENT-VENUS", "PCMCIA 56K DataFax"
  manfid: 0x0200, 0x0001
  function: 2 (serial)

ATI:
Venus K56FLEX V.90 kfav163 PCMCIA p52198

> o Does your modem work flawlessly with Linux 2.4?

Yes, for me it does - with the standard serial.c driver (and
PCMCIA's serial_cs of course) under Linux 2.0/2.2/2.4.

HTH.
Martin

