Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbSJWJho>; Wed, 23 Oct 2002 05:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263517AbSJWJh3>; Wed, 23 Oct 2002 05:37:29 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:2750 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263246AbSJWJgL>; Wed, 23 Oct 2002 05:36:11 -0400
Subject: Re: Lockups in 2.4.19 -- suggestions please
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Hindley <mark@hindley.uklinux.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <15798.25662.10306.174579@mercury.home.hindley.uklinux.net>
References: <15798.25662.10306.174579@mercury.home.hindley.uklinux.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 10:57:42 +0100
Message-Id: <1035367062.3968.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 09:56, Mark Hindley wrote:
> Hi,
> 
> I have been getting recurrent lockups with 2.4.19. Usually when the
> machine is idle and unattended. Often 10/day!!

Does turning off ACPI/APIC/APM stuff help ? What compiler also ?

