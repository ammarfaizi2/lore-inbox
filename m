Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316573AbSGAWsh>; Mon, 1 Jul 2002 18:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSGAWsg>; Mon, 1 Jul 2002 18:48:36 -0400
Received: from AMontpellier-205-1-4-20.abo.wanadoo.fr ([217.128.205.20]:47084
	"EHLO awak") by vger.kernel.org with ESMTP id <S316573AbSGAWsf> convert rfc822-to-8bit;
	Mon, 1 Jul 2002 18:48:35 -0400
Subject: Re: HPT370 + ACPI -> freeze (doesn't boot)
From: Xavier Bestel <xavier.bestel@free.fr>
To: Arnvid Karstad <arnvid@karstad.org>
Cc: Pozsar Balazs <pozsy@uhulinux.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020701221651.10653.qmail@nextgeneration.speedroad.net>
References: <Pine.GSO.4.30.0207012214430.15254-200000@balu> 
	<20020701221651.10653.qmail@nextgeneration.speedroad.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.7 
Date: 02 Jul 2002 00:50:53 +0200
Message-Id: <1025563853.27901.56.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar 02/07/2002 à 00:16, Arnvid Karstad a écrit :
> Hiya, 
> 
> Pozsar Balazs writes:
> > I have an abit VP6 mobo with the integrated HPT370 ide-controller.
> > If I enable ACPI support, and I connect any harddisk to the hpt host, my
> > system locks up hard during boot while initializing the drive(s) on the
> > hpt controller (ie. before printing the 'hde:...' line). The hard drive's
> > led remains lit.
> 
> I have a similar system to yours, but I have drives only on the hpt370 
> controller. My system boots, but crashes after 5 to 15 minuttes regardless 
> of usage. (I've posted this to this list on a previous occation.) 

Mine (ABit VP6, some drives on both controllers) either stops at
"hde:..." at boot or freezes a bit later when ACPI is on with stable
kernels (or -ac ones). Without ACPI it runs pretty well, unless I use
USBnet.

	Xav


