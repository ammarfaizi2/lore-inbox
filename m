Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267038AbSLXDOX>; Mon, 23 Dec 2002 22:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267039AbSLXDOX>; Mon, 23 Dec 2002 22:14:23 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:14477 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S267038AbSLXDOW>; Mon, 23 Dec 2002 22:14:22 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C1AEC82@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'jamesclv@us.ibm.com'" <jamesclv@us.ibm.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>,
       Christoph Hellwig <hch@infradead.org>,
       John Stultz <johnstul@us.ibm.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][2.4]  generic support for systems with more than 8 CP
	 	Us (2/2)
Date: Mon, 23 Dec 2002 21:22:17 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>What is "flat clustered"?  Has Intel cooked up yet another APIC operating 
>mode?   8^)   As far as I knew, the flat and clustered modes were mutually 
>exclusive, based on the value in the DFR.

Yes, I noticed I was using a different "jargon" here - I meant physical
cluster (versus logical cluster).
Somehow, this expression was adopted in our place...

--Natalie

