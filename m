Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262481AbSJ3AMd>; Tue, 29 Oct 2002 19:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262491AbSJ3AMd>; Tue, 29 Oct 2002 19:12:33 -0500
Received: from b.smtp-out.sonic.net ([208.201.224.39]:34513 "HELO
	b.smtp-out.sonic.net") by vger.kernel.org with SMTP
	id <S262481AbSJ3AM3>; Tue, 29 Oct 2002 19:12:29 -0500
X-envelope-info: <apavloff@eason.com>
Message-ID: <D3AF5F134D627243993F2F2FC32EE4D229C3C1@mailman.eason.com>
From: Alex Pavloff <apavloff@eason.com>
To: "'Ed Vance'" <EdV@macrolink.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>,
       "'linux-serial'" <linux-serial@vger.kernel.org>
Subject: RE: what serial port type are Elan ports?
Date: Tue, 29 Oct 2002 16:18:50 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Elan Sc3x0?
Elan Sc4x0?
Elan Sc520?

I assume you mean the 520, if you really want to find the UART for the SC3x0
I might be convinced to plug in a hard drive to one of my many SC320s lying
around and let you know.

Alex Pavloff - apavloff@eason.com
Eason Technology -- www.eason.com

> -----Original Message-----
> From: Ed Vance [mailto:EdV@macrolink.com]
> Sent: Tuesday, October 29, 2002 4:14 PM
> To: 'linux-kernel'; 'linux-serial'
> Subject: what serial port type are Elan ports?
> 
> 
> Hi,
> 
> I need to know what UART type the serial driver detects for 
> the two built-in
> serial ports on the AMD Elan Microcontroller?
> 
> Would some nice person who has an Elan based system please 
> send me the first
> ten lines of the output of the following command?
> 
> 	more /proc/tty/driver/serial
> 
> Thanks in advance,
> Ed
> 
> ---------------------------------------------------------------- 
> Ed Vance              edv (at) macrolink (dot) com
> Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
> ----------------------------------------------------------------
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
