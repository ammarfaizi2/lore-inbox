Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVCCEqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVCCEqq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 23:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVCCEop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 23:44:45 -0500
Received: from 200-170-96-180.veloxmail.com.br ([200.170.96.180]:19238 "EHLO
	200-170-96-186.veloxmail.com.br") by vger.kernel.org with ESMTP
	id S261404AbVCCEjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 23:39:09 -0500
X-Authenticated-User: fredlwm@veloxmail.com.br
X-Authenticated-User: fredlwm@veloxmail.com.br
Date: Thu, 3 Mar 2005 01:39:08 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <2@pervalidus.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: radeonfb blanks my monitor
In-Reply-To: <1109823010.5610.161.camel@gaston>
Message-ID: <Pine.LNX.4.62.0503030134200.311@darkstar.example.net>
References: <Pine.LNX.4.62.0503022347070.311@darkstar.example.net>
 <1109823010.5610.161.camel@gaston>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1252466297-1109824748=:311"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1252466297-1109824748=:311
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 3 Mar 2005, Benjamin Herrenschmidt wrote:

> On Wed, 2005-03-02 at 23:51 -0300, Fr=E9d=E9ric L. W. Meunier wrote:
>> I just replaced my Matrox G400 with a Jetway Radeon 9600LE
>> (256Mb). If I run 'modprobe radeonfb', the monitor blanks out
>> and the power on light keeps flashing.
>>
>> What may be wrong ? Using 2.6.11.
>
> Do you have a way to capture the dmesg log produced ?

These are the lines before I have to use SysRq.

Mar  2 15:16:45 darkstar kernel: radeonfb: Found Intel x86 BIOS ROM Image
Mar  2 15:16:45 darkstar kernel: radeonfb: Retreived PLL infos from BIOS
Mar  2 15:16:45 darkstar kernel: i2c-algo-bit.o: dvi passed test.
Mar  2 15:16:45 darkstar kernel: i2c-algo-bit.o: vga passed test.
Mar  2 15:16:46 darkstar kernel: radeonfb: Monitor 1 type CRT found
Mar  2 15:16:46 darkstar kernel: radeonfb: EDID probed
Mar  2 15:16:46 darkstar kernel: radeonfb: Monitor 2 type no found

BTW, I don't know if it could be related, but my motherboard=20
only supports AGP 4x.

> Also, does it work if radeonfb is built-in ?

I'll try later. Time to sleep.

--=20
How to contact me - http://www.pervalidus.net/contact.html
--8323328-1252466297-1109824748=:311--
