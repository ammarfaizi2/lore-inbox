Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291753AbSCRSqg>; Mon, 18 Mar 2002 13:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291766AbSCRSq0>; Mon, 18 Mar 2002 13:46:26 -0500
Received: from fmr02.intel.com ([192.55.52.25]:42179 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S291753AbSCRSqH>; Mon, 18 Mar 2002 13:46:07 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7D07@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'torvalds@transmeta.com'" <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Cc: "Diefenbaugh, Paul S" <paul.s.diefenbaugh@intel.com>
Subject: RE: Oops in 2.5.7-pre2: ACPI?
Date: Mon, 18 Mar 2002 10:43:45 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: torvalds@transmeta.com [mailto:torvalds@transmeta.com]
> I fixed the non-ACPI brokenness, which then left the ACPI merge in a
> halfway state..  So right now ACPI device initialization 
> doesn't work. 
> I'm hoping that the ACPI folks can fix up their broken 
> assumptions soon. 

I can see from bkbits looks like you already fixed it post-pre2, so I guess
we will just sit tight and everything will be fine once pre3 is out.

Thanks -- Regards -- Andy
