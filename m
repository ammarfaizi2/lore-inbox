Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268412AbTANABH>; Mon, 13 Jan 2003 19:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268428AbTANABH>; Mon, 13 Jan 2003 19:01:07 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:52368 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S268412AbTANABG>; Mon, 13 Jan 2003 19:01:06 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C022BD8EC@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'Martin J. Bligh'" <mbligh@aracnet.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: APIC version
Date: Mon, 13 Jan 2003 18:09:43 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> If you index it by 4-bit GET_APIC_ID() (not GET_APIC_LOGICAL_ID()), i.e.
>> hard_smp_processor_id(), you can get away with it.

Oops, you're right! what was I thinking...

