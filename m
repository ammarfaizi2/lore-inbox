Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbTANEm7>; Mon, 13 Jan 2003 23:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbTANEm7>; Mon, 13 Jan 2003 23:42:59 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:14793 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S261529AbTANEm6>; Mon, 13 Jan 2003 23:42:58 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BD8F3@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'Martin J. Bligh'" <mbligh@aracnet.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "'Nakajima, Jun'" <jun.nakajima@intel.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: APIC version
Date: Mon, 13 Jan 2003 22:51:30 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, Martin. You win. I am satisfied and I give up. I guess I like
apic_version[] the way it is now :)

--N
-----Original Message-----
From: Martin J. Bligh [mailto:mbligh@aracnet.com]
Sent: Monday, January 13, 2003 9:44 PM
To: Protasevich, Natalie; 'Nakajima, Jun'; Zwane Mwaikambo
Cc: Pallipadi, Venkatesh; Linux Kernel
Subject: RE: APIC version


> True - it has to be only done once per CPU bring-up.
> 
> To investigate all the corners of this issue: is it possible now,
tomorrow,
> on in the future to mix Intel processors on the same machine? 

Yes. We can mix PPro 180s up with P3 900s, for a long time now.

> enough really to collect the APIC version of boot CPU and just use it for
> the rest? 

Nope. 

M.
