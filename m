Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273141AbRJIG4G>; Tue, 9 Oct 2001 02:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273333AbRJIGz4>; Tue, 9 Oct 2001 02:55:56 -0400
Received: from [195.66.192.167] ([195.66.192.167]:6413 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S273305AbRJIGzl>; Tue, 9 Oct 2001 02:55:41 -0400
Date: Tue, 9 Oct 2001 09:54:18 +0200
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <6389746438.20011009095418@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Re: Have problems with big kernel? Here is a loadlin replacement
In-Reply-To: <96651944.20011008104923@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <96651944.20011008104923@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Replying to myself is strange, but...

V> Some time ago I have been bitten by loadlin refusing
V> to load bzImages bigger than 1023623 bytes (well,
V> that's the size of biggest one which it can load for me).

V> Tried to fix it. Decided that fiddling with that much
V> asm is not productive. Wrote a replacement. See attached tar.
V> It works for me. It is as much alpha as it can probably
V> be, but it works. I have lots of ideas how to improve it.

Improved it. It has commandline params now :-)
This means included .exe is almost usable
(if you are fine with hardcoded vga=0x303 or ready to
patch it with binary editor)

TODO: initrd, vga=xxx
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua


