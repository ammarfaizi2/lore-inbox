Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278275AbRJOUpj>; Mon, 15 Oct 2001 16:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278281AbRJOUpa>; Mon, 15 Oct 2001 16:45:30 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:34753 "HELO
	postfix2-1.free.fr") by vger.kernel.org with SMTP
	id <S278275AbRJOUpV>; Mon, 15 Oct 2001 16:45:21 -0400
Date: Mon, 15 Oct 2001 22:45:49 +0200
From: christophe barbe <christophe.barbe@online.fr>
To: "Justin T . Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] export pci_table in aic7xxx for Hotplug
Message-ID: <20011015224549.G2665@turing>
In-Reply-To: <20011015222311.E2665@turing> <200110152031.f9FKVlY56104@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <200110152031.f9FKVlY56104@aslan.scsiguy.com>; from gibbs@scsiguy.com on lun, oct 15, 2001 at 22:31:47 +0200
X-Mailer: Balsa 1.2.pre3
X-Operating-System: debian SID Gnu/Linux 2.4.12 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Le 2001.10.15 22:31:47 +0200, Justin T. Gibbs a écrit :
> >I have defined __NO_VERSION__ before including module.h because in my
> >understanding this is required when you include it in a multi-files
> module.
> >Only one file must include module.h without defining the __NO_VERSION__.
> 
> I can find no reference to "__NO_VERSION__" in module.h or the files
> it includes.   Perhaps this is a requirement for old kernels?

Perhaps I take it from the 2nd edition of Linux Device Drivers (normally
uptodate) but I should said that I've not checked in the .h file.
I guess it's at least harmless but if it works without it's better without.

> >I remember to read something about a repository for your new driver.
> Please
> >could you point it to me and I will try it ASAP.
> 
> http://people.FreeBSD.org/~gibbs/linux/

Thank, I will check it.

> 
> --
> Justin
> 
-- 
Christophe Barbé <christophe.barbe@online.fr>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E
