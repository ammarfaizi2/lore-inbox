Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSH1Quu>; Wed, 28 Aug 2002 12:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSH1Qut>; Wed, 28 Aug 2002 12:50:49 -0400
Received: from air-2.osdl.org ([65.172.181.6]:22276 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S312590AbSH1Qut>;
	Wed, 28 Aug 2002 12:50:49 -0400
Date: Wed, 28 Aug 2002 09:53:59 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <root@chaos.analogic.com>, <yodaiken@fsmlabs.com>,
       Mark Hounschell <markh@compro.net>,
       "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: interrupt latency
In-Reply-To: <1030548687.7190.33.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33L2.0208280953300.31860-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Aug 2002, Alan Cox wrote:

| I would expect port 0x378 on any modern PC to be on the X-bus not on ISA

Yes, or what (intel) calls the Low Pin Count (LPC) bus.

-- 
~Randy

