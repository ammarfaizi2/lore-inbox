Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267476AbSLRURj>; Wed, 18 Dec 2002 15:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267477AbSLRURj>; Wed, 18 Dec 2002 15:17:39 -0500
Received: from fmr02.intel.com ([192.55.52.25]:35821 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267476AbSLRURi>; Wed, 18 Dec 2002 15:17:38 -0500
Message-ID: <8A9A5F4E6576D511B98F00508B68C20A1508E3D9@orsmsx106.jf.intel.com>
From: "Shureih, Tariq" <tariq.shureih@intel.com>
To: "'Chris Wright'" <chris@wirex.com>
Cc: "Lmkl (linux-kernel@vger.kernel.org)" <linux-kernel@vger.kernel.org>
Subject: RE: QM_MODULES: Function not implemented
Date: Wed, 18 Dec 2002 12:25:28 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanx.  Just as I was waiting for your email, I was going through the kernel
to see where the message was coming from and {KABOOM} it hit me.  This is
coming from lsmod! Duh!

Thank you again :)

--
Tariq Shureih
Intel Corporation
Opinions are my own and don't represent my emplyer

-----Original Message-----
From: Chris Wright [mailto:chris@wirex.com] 
Sent: Wednesday, December 18, 2002 12:19 PM
To: Shureih, Tariq
Cc: Lmkl (linux-kernel@vger.kernel.org)
Subject: Re: QM_MODULES: Function not implemented

* Shureih, Tariq (tariq.shureih@intel.com) wrote:
> 
> Kernel boots just fine, howeverl, "lsmod" gives me a messages:
"QM_MODULES:
> Function not implemented"

Did you update your module tools?

ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/modules/

-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
