Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292960AbSBVTcx>; Fri, 22 Feb 2002 14:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292961AbSBVTco>; Fri, 22 Feb 2002 14:32:44 -0500
Received: from mustard.heime.net ([194.234.65.222]:10368 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S292960AbSBVTce>; Fri, 22 Feb 2002 14:32:34 -0500
Date: Fri, 22 Feb 2002 20:32:19 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Christer Weinigel <wingel@acolyte.hack.org>
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
In-Reply-To: <Pine.LNX.4.44.0202221207300.30230-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.30.0202222030570.11804-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002, Zwane Mwaikambo wrote:
> Here's a finalised version, with the recommended changes (including
> probe). ISAPNP to follow shortly. Alan, regarding that race in ioctl,
> read/write. Wouldn't the open semaphore protect against that in this case.
> Otherwise irq safe spinlocks could be added to read/write.

Can anyone make a patch out of this?

thanks

roy

--
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

