Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313598AbSDHJcR>; Mon, 8 Apr 2002 05:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313599AbSDHJcQ>; Mon, 8 Apr 2002 05:32:16 -0400
Received: from dialin-145-254-148-091.arcor-ip.net ([145.254.148.91]:55814
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S313598AbSDHJcQ>; Mon, 8 Apr 2002 05:32:16 -0400
Message-ID: <3CB16335.C4BF320C@loewe-komp.de>
Date: Mon, 08 Apr 2002 11:30:29 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.18-ul i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Pierre Ficheux <pierre.ficheux@openwide.fr>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 AND Geode GX1/200Mhz problem
In-Reply-To: <3CB0D419.F785C6D0@openwide.fr> <E16uMHW-0006vK-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> >       I have a strange problem with a Geode/GX1 200Mhz based system. My
> > kernel is compiled  with 586 as processor type but the system stops just
> > after the 'Uncompressing Linux...Ok, booting the kernel' message. It's
> > strange as GX1 is claimed to work fine with 2.4.18. The same system
> > works fine with 2.2.18 kernel.
> 
> With 586 and no TSC set it should work fine yes. You might want to plug a
> serial port in and compile with serial console enabled, see if it gives any
> clues

I want to translate this to:

Processor -> 586/K5/5x86/6x86/6x86MX

right?
