Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291509AbSBHJxb>; Fri, 8 Feb 2002 04:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291510AbSBHJxV>; Fri, 8 Feb 2002 04:53:21 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:47371 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S291509AbSBHJxF>; Fri, 8 Feb 2002 04:53:05 -0500
Message-Id: <200202080951.g189pJt14876@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Jim Treadway <jim@stardot-tech.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add support for Lava Octopus PCI serial card
Date: Fri, 8 Feb 2002 11:51:22 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.44.0202071722230.11456-100000@cerberus.stardot-tech.com>
In-Reply-To: <Pine.LNX.4.44.0202071722230.11456-100000@cerberus.stardot-tech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 February 2002 23:38, Jim Treadway wrote:
> This patch (against 2.4.17) adds support for the "Lava Octopus-550" (a
> multiport PCI serial card).
>
> I'm not sure exactly who the maintainer of the serial driver for the 2.4.X
> branch is, and the linux-serial list seems to be rather dead, so I'm
> sending it here.
>
> If anyone knows of a better place to send this, please let me know. ;)

Don't know for 2.4, but:

Russell King <rmk@arm.linux.org.uk> [06 feb 2002]
	ARM architecture maintainer.  Please send all ARM patches through
	the patch system at http://www.arm.linux.org.uk/developer/patches/
	New serial drivers maintainer for 2.5.  Submit patches to
	rmk+serial@arm.linux.org.uk

Alan Cox <alan@lxorguk.ukuu.org.uk> [5 feb 2002]
	2.2 maintainer.
	He collects various bits and pieces for inclusion in 2.4.

Dave Jones <davej@suse.de> [5 feb 2002]
	Collects various bits and pieces for inclusion in 2.5,
	espesially small and trivial ones and driver updates.

--
vda
