Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267008AbTAaNkm>; Fri, 31 Jan 2003 08:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267026AbTAaNkm>; Fri, 31 Jan 2003 08:40:42 -0500
Received: from matrix.roma2.infn.it ([141.108.255.2]:27332 "EHLO
	matrix.roma2.infn.it") by vger.kernel.org with ESMTP
	id <S267008AbTAaNkl>; Fri, 31 Jan 2003 08:40:41 -0500
Message-ID: <55699.141.108.7.31.1044021002.squirrel@webmail.roma2.infn.it>
Date: Fri, 31 Jan 2003 14:50:02 +0100 (CET)
Subject: Re: yenta-cardbus IRQ0
From: "Emiliano Gabrielli" <emiliano.gabrielli@roma2.infn.it>
To: <rbisping@mindspring.com>
In-Reply-To: <E18eXoy-0000iL-00@tisch.mail.mindspring.net>
References: <E18eXoy-0000iL-00@tisch.mail.mindspring.net>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


<quote who="Robert Bisping">
> i have been trying to set up a cardbus card on my thinkpad 760ED for about  the last
> month and it keeps coming up with IRQ0 and telling me it cant find a  irq for pin A.
> what would be causing this and how do I correct it i have  already tried APCI and it
> does not work on my laptop so that is no help. I  have compiled SMP into the kernel
> though I dont have a dual processor (of  course) to gain the added functionality. I
> have recompiled my kernel about  150 times with different setting hoping it might just
> be a conflict in the  kernel with no luck.  I looked at the yenta driver it's self and
> noticed that  it accepts IRQ0 as a valid irq but that appears to mean no irq at all.
> which  config file would i use to force it to set a irq?
>
>
> Thanx for any assistanc you might give
>

plz send an lspci -vv -xxx -s *your dev*

what kernel are you using ?

-- 
Emiliano Gabrielli

dip. di Fisica
2° Università di Roma "Tor Vergata"


