Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287387AbSACQTj>; Thu, 3 Jan 2002 11:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287386AbSACQTd>; Thu, 3 Jan 2002 11:19:33 -0500
Received: from vsat-148-63-243-254.c3.sb4.mrt.starband.net ([148.63.243.254]:260
	"HELO ns1.ltc.com") by vger.kernel.org with SMTP id <S287379AbSACQTF>;
	Thu, 3 Jan 2002 11:19:05 -0500
Message-ID: <00ae01c19472$60ce25f0$5601010a@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: <serge.manigault@ask.fr>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3C347F73.1F6FD8A0@ask.fr>
Subject: Re: romable kernel (XIP)
Date: Thu, 3 Jan 2002 11:19:11 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is support in http://www.linux-vr.org for XIP kernel.  grep for
CONFIG_XIP_ROM and look in arch/mips/vr41xx for the linker script.

Note: linux-vr.org repository is old and being phased out and code moved to
linux-mips.sourceforge.net.

Regards,
Brad

----- Original Message -----
From: "Serge Manigault" <asksmanig@ask.fr>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, January 03, 2002 10:57 AM
Subject: romable kernel (XIP)


> Hello,
> I am looking for information about Linux XIP for eXecute In Place
> I need a romable image to minimize RAM usage.
> Thanks for any information, link, or anything else about this subject.
> regards,
>
> Serge

