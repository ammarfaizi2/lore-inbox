Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317017AbSHOO3D>; Thu, 15 Aug 2002 10:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317023AbSHOO3D>; Thu, 15 Aug 2002 10:29:03 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:12294 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S317017AbSHOO3C>; Thu, 15 Aug 2002 10:29:02 -0400
Message-ID: <3D5BBC06.D1BA147E@aitel.hist.no>
Date: Thu, 15 Aug 2002 16:34:46 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.31 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: [ANNOUNCE] New PC-Speaker driver
References: <3D5A8C2C.9010700@yahoo.com> <200208150821.g7F8L6p19730@Port.imtp.ilyichevsk.odessa.ua> <E17fI5E-0002at-00@starship> <200208151137.g7FBbNp20417@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

> It won't work well for everybody, then it won't live in mainline.
Bad reason.  You can select IDE without the fixes for your
particular buggy IDE adapter and have it eat the disks.  Still,
turning off RZ1000 and CMDxxx fixes is possible for those
that know they have a good adapter.

So, no need to reject the speaker driver for "crap sound".
It'll be usable with a good speaker, and the config help
text can simply state that it is a last-resort driver
which might work badly because it pushes the hardware.

> Because newcomers will enable it, be pissed off with crap sound etc...
> "Political" reasons I'm afraid...

The senseless cpu usage for something as simple as sound
is worse.  Consider putting a old voice modem on a serial
port and connect a speaker to the phone output...

Helge Hafting
