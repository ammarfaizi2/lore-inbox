Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTHTSTz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 14:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbTHTSTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 14:19:55 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:39868 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262123AbTHTSTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 14:19:53 -0400
Date: Wed, 20 Aug 2003 15:15:43 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: "Brown, Len" <len.brown@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "J.A. Magallon" <jamagallon@able.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, acpi-devel@sourceforge.net
Subject: RE: [patch] 2.4.x ACPI updates
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FC7F@hdsmsx402.hd.intel.com>
Message-ID: <Pine.LNX.4.55L.0308201514140.617@freak.distro.conectiva>
References: <BF1FE1855350A0479097B3A0D2A80EE009FC7F@hdsmsx402.hd.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Aug 2003, Brown, Len wrote:

> Andy/Jeff/Marcelo,
>
> At Jeff's request, I've back ported ACPICA 20030813 from
> http://linux-acpi.bkbits.net/linux-acpi-2.4 into a new tree for 2.4.22:
> http://linux-acpi.bkbits.net/linux-acpi-2.4.22
>
> I've restored acpitable.[ch], which was deleted too late for this
> release cycle; and will live on until 2.4.23 -- as well as restored
> CONFIG_ACPI_HT_ONLY under CONFIG_ACPI; restored the 8-bit characters
> that got expanded to 16-bits in a previous merge; and deleted some dmesg
> verbiage that Jeff didn't think was appropriate for the baseline kernel.
>
> I exported this a patch and then imported onto a clone of Marcelo's
> tree, so it appears as a single cset where the changes that got un-done
> never happened.  I've done some sanity tests on it, and will test it
> some more tomorrow.  Take a look at it and let me know if I missed
> anything.  When Andy is happy with it I'll leave it to him to re-issue a
> pull request from Marcelo.

Cool!!

Ill try to take a look at the patch now (having serious conectivity issues
:()

