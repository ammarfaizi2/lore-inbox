Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286575AbRLUVIs>; Fri, 21 Dec 2001 16:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286577AbRLUVIb>; Fri, 21 Dec 2001 16:08:31 -0500
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:44509 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S286575AbRLUVIY>; Fri, 21 Dec 2001 16:08:24 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D814@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Pavel Machek'" <pavel@suse.cz>,
        Kimio Suganuma <k-suganuma@mvj.biglobe.ne.jp>
Cc: linux-kernel@vger.kernel.org, large-discuss@lists.sourceforge.net,
        Heiko Carstens <Heiko.Carstens@de.ibm.com>,
        Jason McMullan <jmcmullan@linuxcare.com>,
        Anton Blanchard <antonb@au1.ibm.com>,
        Greg Kroah-Hartman <ghartman@us.ibm.com>, rusty@rustcorp.com.au
Subject: RE: [ANNOUNCE] HotPlug CPU patch against 2.5.0
Date: Fri, 21 Dec 2001 13:08:13 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Pavel Machek [mailto:pavel@suse.cz]
> > This patch works on s390, s390x, x86 and ia64 architectures.
> > It can also be applied against 2.4.16 with a little modification.
> > 
> > Down CPU
> > echo 0 > /proc/sys/kernel/cpu/<id>/online
> > 
> > Up CPU
> > echo 1 > /proc/sys/kernel/cpu/<id>/online
> 
> Such patches are neccessary for ACPI S3/S4 sleep support. It 
> would be nice to
> apply them soon.

They are???

How so?

Regards -- Andy
