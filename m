Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312266AbSCTXJx>; Wed, 20 Mar 2002 18:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312271AbSCTXJp>; Wed, 20 Mar 2002 18:09:45 -0500
Received: from CPE-203-51-26-136.nsw.bigpond.net.au ([203.51.26.136]:4337 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S312266AbSCTXJC>; Wed, 20 Mar 2002 18:09:02 -0500
Message-ID: <3C99168A.F30EB8D6@eyal.emu.id.au>
Date: Thu, 21 Mar 2002 10:08:58 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre3-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre4: pdcadma.c still missing ?
In-Reply-To: <Pine.LNX.4.21.0203201757560.9129-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> So here goes pre4, now with a much more detailed changelog...

Or maybe the makefile should not include it?

ld: cannot open pdcadma.o: No such file or directory
make[3]: *** [ide-mod.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/ide'

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
