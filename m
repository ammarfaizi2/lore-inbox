Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbSKKUgI>; Mon, 11 Nov 2002 15:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261332AbSKKUgI>; Mon, 11 Nov 2002 15:36:08 -0500
Received: from fmr02.intel.com ([192.55.52.25]:6873 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261338AbSKKUgH>; Mon, 11 Nov 2002 15:36:07 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CAC918@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Dominik Brodowski'" <linux@brodo.de>
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: RE: [2.5. PATCH] cpufreq: correct initialization on Intel Copperm
	 ines
Date: Mon, 11 Nov 2002 12:42:51 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Cannot you use ACPI to detect that? AFAIK, if the machine 
> > supports it, it is doable.
> 
> Most PIII Coppermine notebooks only have ACPI 1.x which does 
> not include
> "Performance States" - an interface to Intel SpeedStep and 
> other, similar 
> technologies. 

Bummer - that was something I did not know; thanks for your clarification -
this was the only sollution I found (without IP concerns) when I was
enquiring how to get the specifications to support performance states.

Thanks,

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]
