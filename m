Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267126AbTAFTcA>; Mon, 6 Jan 2003 14:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267129AbTAFTcA>; Mon, 6 Jan 2003 14:32:00 -0500
Received: from fmr02.intel.com ([192.55.52.25]:1013 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267126AbTAFTb6> convert rfc822-to-8bit; Mon, 6 Jan 2003 14:31:58 -0500
content-class: urn:content-classes:message
Subject: KIRQ Balance
Date: Mon, 6 Jan 2003 11:40:31 -0800
Message-ID: <E88224AA79D2744187E7854CA8D9131DA5CE4A@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: KIRQ Balance
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcKqWDy9b2nV1hZKEdeNCQBQi+Bs2ALYevNQ
From: "Kamble, Nitin A" <nitin.a.kamble@intel.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       "William Lee Irwin III" <wli@holomorphy.com>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "James Cleverdon" <jamesclv@us.ibm.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "John Stultz" <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>,
       "Andi Kleen" <ak@suse.de>, "Hubert Mantel" <mantel@suse.de>,
       "Schlobohm, Bruce" <bruce.schlobohm@intel.com>
X-OriginalArrivalTime: 06 Jan 2003 19:40:32.0093 (UTC) FILETIME=[7973A8D0:01C2B5BB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Martin J. Bligh [mailto:mbligh@aracnet.com] 
Sent: Sunday, December 22, 2002 11:52 PM
Subject: RE: [PATCH][2.4] generic cluster APIC support for systems with
m ore than 8 CPUs

If you're interested in working on it, I'm very happy to test it ...
(should probably be kept seperate from your other stuff though).
I'll see if I can find someone in our performance team to evaluate 
how your existing patch runs on SMP for us ...

M.

Hi Martin,
  Would somebody get a chance to try the kirq patch out? If yes, please
let me know, how the patch did on your systems. Did your guys find any
issues with it? I will also appreciate more comments.

Thanks & Regards,
Nitin
