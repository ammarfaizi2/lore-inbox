Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284171AbRLARm0>; Sat, 1 Dec 2001 12:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284168AbRLARmQ>; Sat, 1 Dec 2001 12:42:16 -0500
Received: from smtp2.libero.it ([193.70.192.52]:24452 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S284164AbRLARmL>;
	Sat, 1 Dec 2001 12:42:11 -0500
Date: Sat, 1 Dec 2001 18:41:14 +0100
From: Emmanuele Bassi <emmanuele.bassi@iol.it>
To: linux-kernel@vger.kernel.org
Subject: Re: Deadlock on kernels > 2.4.13-pre6
Message-ID: <20011201184114.A1195@wolverine.lohacker.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011130221334.A15353@wolverine.lohacker.net> <E169wJt-00052j-00@the-village.bc.nu> <20011201143943.A1851@wolverine.lohacker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011201143943.A1851@wolverine.lohacker.net>
User-Agent: Mutt/1.3.23i
X-Mailer: Mutt 1.3.23i (2001-10-09)
X-OS: Linux 2.4.13-pre6 i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Emmanuele Bassi <emmanuele.bassi@iol.it>:

> Just to be certain, I have an old PCI graphic card (a Matrox Mystique)
> that worked nicely since three years now... If that works nice, this
> should be the final proof...

Tested on the old Mystique. The system hangs up after a while (kernel
2.4.16)... At this point, I think I should blame the kernel, or some
workaround to this fscking chipset.

Bye,
 Emmanuele.

-- 
Emmanuele Bassi (Zefram)               [ http://digilander.iol.it/ebassi ]
GnuPG Key fingerprint = 4DD0 C90D 4070 F071 5738  08BD 8ECC DB8F A432 0FF4
