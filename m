Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266041AbRGCWCd>; Tue, 3 Jul 2001 18:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266036AbRGCWCN>; Tue, 3 Jul 2001 18:02:13 -0400
Received: from jffdns01.or.intel.com ([134.134.248.3]:11232 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S266034AbRGCWCM>; Tue, 3 Jul 2001 18:02:12 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDDF30@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'arjan@fenrus.demon.nl'" <arjan@fenrus.demon.nl>
Cc: linux-kernel@vger.kernel.org
Subject: RE: ACPI fundamental locking problems
Date: Tue, 3 Jul 2001 15:01:41 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: arjan@fenrus.demon.nl [mailto:arjan@fenrus.demon.nl]
> > BTW of course ACPI can be turned off via make menuconfig.
> 
> Can you point me to the name of the option? I can't find it on my IA64

ACPI is required for IA64 to boot, so you can't disable it AFAIK. Sorry, I
should have included that caveat in my previous message.

-- Andy

