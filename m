Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317215AbSGNX0r>; Sun, 14 Jul 2002 19:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317217AbSGNX0q>; Sun, 14 Jul 2002 19:26:46 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:35830 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317215AbSGNX0p>; Sun, 14 Jul 2002 19:26:45 -0400
Subject: Re: apm power_off on smp
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pozsar Balazs <pozsy@uhulinux.hu>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
       Kelledin <kelledin+LKML@skarpsey.dyndns.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.30.0207150101150.27346-100000@balu>
References: <Pine.GSO.4.30.0207150101150.27346-100000@balu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 15 Jul 2002 01:39:02 +0100
Message-Id: <1026693542.13885.94.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-15 at 00:03, Pozsar Balazs wrote:
> 
> Yes, all I want is poweroff.
> I understand that apm is not smp safe, and pretty much all of it is
> disabled in smp mode.
> 
> What i do not understand is why the poweroff functionality is disabled by
> default.

Because it too is unsafe on some machines

