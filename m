Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277366AbRKITL2>; Fri, 9 Nov 2001 14:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280027AbRKITLT>; Fri, 9 Nov 2001 14:11:19 -0500
Received: from [192.55.52.18] ([192.55.52.18]:33274 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S277366AbRKITLF>;
	Fri, 9 Nov 2001 14:11:05 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D724@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Anders Peter Fugmann'" <afu@fugmann.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [PATCH] fix ACPI multible power entries
Date: Fri, 9 Nov 2001 11:10:59 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We should already be handling multiple power button definitions, so I'm
confused why you're still seeing the problem. Could you please send me your
dmesg output and /proc/acpi/dsdt output?

Thanks -- Regards -- Andy

> -----Original Message-----
> From: Anders Peter Fugmann [mailto:afu@fugmann.dhs.org]
> Sent: Friday, November 09, 2001 4:01 AM
> To: andrew.grover@intel.com
> Cc: linux-kernel@vger.kernel.org
> Subject: [PATCH] fix ACPI multible power entries
> Importance: High
> 
> 
> Hi.
> 
> In trying to get ACPI to work on my system, i was stumbled to see two 
> button entries under /proc/acpi/button/.
> 
> Attached is a patch which corrects this behaviour.
> The patch applies to 2.4.14.
> 
> Regards
> Anders Fugmann
> 
> 
> 
