Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267451AbUIJPC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267451AbUIJPC6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 11:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267450AbUIJPC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 11:02:57 -0400
Received: from the-village.bc.nu ([81.2.110.252]:15025 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267452AbUIJPCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:02:44 -0400
Subject: Re: seems to be impossible to disable CONFIG_SERIAL [2.6.7]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0409101457180.981@scrub.home>
References: <20040910110819.GE14060@lkcl.net>
	 <20040910120950.D22599@flint.arm.linux.org.uk>
	 <20040910122059.GG14060@lkcl.net>
	 <20040910133545.E22599@flint.arm.linux.org.uk>
	 <Pine.LNX.4.61.0409101457180.981@scrub.home>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094824806.17442.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 15:00:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-10 at 13:59, Roman Zippel wrote:
> > http://linux.bkbits.net:8080/linux-2.5/cset@3f6e2888FMm2_snV3LfsXw6tII6QvA?nav=index.html|src/|src/drivers|src/drivers/char|related/drivers/char/Kconfig
> 
> Should mwave use register_serial at all?

Mwave loads the DSP firmware and that creates a virtual 16x50 UART .

