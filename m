Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262224AbTAVRUk>; Wed, 22 Jan 2003 12:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262266AbTAVRUk>; Wed, 22 Jan 2003 12:20:40 -0500
Received: from web14712.mail.yahoo.com ([216.136.232.92]:58720 "HELO
	web14712.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262224AbTAVRUj>; Wed, 22 Jan 2003 12:20:39 -0500
Message-ID: <20030122172947.59508.qmail@web14712.mail.yahoo.com>
Date: Wed, 22 Jan 2003 18:29:47 +0100 (CET)
From: =?iso-8859-1?q?Marco=20Romano?= <marknonso@yahoo.it>
Subject: drive not ready for command??(on ASUS A7V8X)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I own an ASUS A7V8X Motherboard with an Athlon XP
1700+ upgraded from my quite old PIII 450 Katmai. I've
noticed immediatly that kernel 2.4.19 that I had
utilized with my old system doesn't support DMA and
other features on my new motherboard.
So then I've upgraded to 2.4.20 that should support
it. When I've started the system with the new kernel
the system have locked on the initialization of my
"hdc" (that is a DVD reader of I don't know what brand
, it seems to be quite old) with this message :

hdc: status timeout: error=0x24Aborted Command
LastFailedSense 0x02
hdc: Drive not ready for command
hdc: Drive not ready for command
ide1: reset success!!
:????:
What does this means?

I've tried with kernel 2.4.20 vanilla

2.4.20-ac2
2.4.21-pre3
2.4.21-pre3-ac4

without any results

This motherboard have a chipset composed by KT400
NorthBridge and a VT8235 SouthBridge

HELP ME PLEASEEEEE!!!

Bye 

Marco


______________________________________________________________________
Yahoo! Cellulari: loghi, suonerie, picture message per il tuo telefonino
http://it.yahoo.com/mail_it/foot/?http://it.mobile.yahoo.com/index2002.html
