Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267176AbTBLPVV>; Wed, 12 Feb 2003 10:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267183AbTBLPVV>; Wed, 12 Feb 2003 10:21:21 -0500
Received: from caipirinha.heise.de ([193.99.145.36]:57511 "EHLO
	caipirinha.heise.de") by vger.kernel.org with ESMTP
	id <S267176AbTBLPVU> convert rfc822-to-8bit; Wed, 12 Feb 2003 10:21:20 -0500
From: Thorsten Leemhuis <thl@ct.heise.de>
Date: Wed, 12 Feb 2003 15:30:55 GMT
Message-ID: <20030212.15305500@thl.ct.heise.de>
Subject: Re: Problems with hyper-threading on Asus P4T533 / Linux 2.4.20
To: Lars Magne Ingebrigtsen <larsi@gnus.org>, linux-kernel@vger.kernel.org
In-Reply-To: <mng==m365rpegts.fsf@quimbies.gnus.org>
References: <mng==m365rpegts.fsf@quimbies.gnus.org>
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18iyqa-000840-00*wOlUNyifDQI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

>>>>>>>>>>>>>>>>>> Ursprüngliche Nachricht <<<<<<<<<<<<<<<<<<

Am 12.02.03, 15:12:29, schrieb Lars Magne Ingebrigtsen <larsi@gnus.org> zum 
Thema Problems with hyper-threading on Asus P4T533 / Linux 2.4.20:


> We've just gotten an Asus P4T533-based machine with a 3.06GHz P4 CPU,
> bios version 1005.  (P4T533 is i850e-based.)  The bios claims that the
> P4 has hyper-threading, and as you can see from the cpuinfo output
> below, "ht" is among the flags.  (And the manual says that P4T533 is
> ht-enabled.)

> I've tried booting with acpismp=force and without, and it doesn't
> seem to make much difference: Linux still only sees a single CPU.
> I've also tried 2.4.21-pre4 and -ac4, which doesn't seem to make any
> difference, either.

> Anybody got any ideas why I can't get this to work?

[...]

I know some other Asus Boards that only work in HT mode when you're using 
ACPI Patches from

http://sourceforge.net/project/showfiles.php?group_id=36832

But I don't know why -- Maybe someone else knows why?

CU
Thorsten Leemhuis


