Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317058AbSGCPxR>; Wed, 3 Jul 2002 11:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317036AbSGCPxQ>; Wed, 3 Jul 2002 11:53:16 -0400
Received: from exchange.macrolink.com ([64.173.88.99]:14865 "EHLO
	exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S317058AbSGCPxO>; Wed, 3 Jul 2002 11:53:14 -0400
Message-ID: <11E89240C407D311958800A0C9ACF7D13A78AA@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Tony Lindgren'" <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, "'Russell King'" <rmk@arm.linux.org.uk>
Subject: RE: w83627hf fast serial port driver available
Date: Wed, 3 Jul 2002 08:55:39 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, July 02, 2002 at 7:20 PM, Tony Lindgren wrote:
> 
> I just posted a driver that enables the high speed serial port 
> modes for the w83627 chip used on many motherboards, such as 
> Tyan S2460.
> 
> To use the driver, you also need to use setserial after loading 
> the driver to enable the high speed mode.
> 
> Hopefully somebody someday will combine all the high speed serial
> port drivers into some generic high speed serial port driver...

The someday is actually coming soon.

Russell King is wizarding on unification of the serial drivers for 
the 2.5 kernel. IIRC, the approach was to eliminate duplicated code, 
rather than eliminate drivers, per se. 

> 
> You can also download the driver from:
> 
> https://www.muru.com/linux/w83627hf/
> 
> Tony
