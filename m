Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316072AbSENV22>; Tue, 14 May 2002 17:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316073AbSENV20>; Tue, 14 May 2002 17:28:26 -0400
Received: from mailhost.terra.es ([195.235.113.151]:4123 "EHLO tsmtp4.mail.isp")
	by vger.kernel.org with ESMTP id <S316072AbSENV1x>;
	Tue, 14 May 2002 17:27:53 -0400
Date: Tue, 14 May 2002 23:28:02 +0200
From: Diego Calleja <DiegoCG@teleline.es>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre8-ac3
Message-Id: <20020514232803.237eda1f.DiegoCG@teleline.es>
In-Reply-To: <200205141244.g4ECi6P29886@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002 08:44:06 -0400 (EDT)
Alan Cox <alan@redhat.com> escribió:

> The usual IDE merge comments apply. Please treat this tree with care.
> It should have knocked out more of the weirdnesses as well as providing the
> basis for upcoming restructuring of stuff for mmio etc.
> 
> 
> [+ indicates stuff that went to Marcelo, o stuff that has not,
>  * indicates stuff that is merged in mainstream now, X stuff that proved
>    bad and was dropped out]
> 
> Linux 2.4.19pre8-ac3
> o	Kbuild fixes					(Keith Owens)
> o	Fix eepro100 bug/typo				(Michael Rozhavsky)
> o	Intel 845G GART support				(Graeme Fisher)
> o	Fix tasklet disable/kill in pppoatm		(Luca Barbier)
> o	Add another PCI ident to the acenic driver	(Eric Smith)
> o	Major IDE updates				(Andre Hedrick)

There's a very strange file in the top of the tree.....
