Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbSLTQXT>; Fri, 20 Dec 2002 11:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbSLTQXT>; Fri, 20 Dec 2002 11:23:19 -0500
Received: from franka.aracnet.com ([216.99.193.44]:60077 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262469AbSLTQXS>; Fri, 20 Dec 2002 11:23:18 -0500
Date: Fri, 20 Dec 2002 08:30:29 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
cc: "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with
 m	ore than 8 CPUs
Message-ID: <130020000.1040401828@titus>
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C0101F55D@usslc-exch-4.slc.unisys.com>
References: <3FAD1088D4556046AEC48D80B47B478C0101F55D@usslc-exch-4.slc.unisy
 s.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Natalie is the engineer who added support for the ES7000 to Linux.
> Fortunately she is in the cube next to me.
>
> She has sent the patches to SuSe/United Linux, and is in the final process
> of testing them on 2.5.5x before submitting them to LKML for comment.

Are they under subarch or somehow abstracted this time, or are there
going to be 10,000 ifdef's again? If the latter, I can predict what
the first set of review comments you get are going to be ;-)

M.

