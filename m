Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267871AbTAMSWR>; Mon, 13 Jan 2003 13:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267885AbTAMSWR>; Mon, 13 Jan 2003 13:22:17 -0500
Received: from franka.aracnet.com ([216.99.193.44]:18827 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267871AbTAMSWQ>; Mon, 13 Jan 2003 13:22:16 -0500
Date: Mon, 13 Jan 2003 10:30:11 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
cc: "'Pallipadi, Venkatesh'" <venkatesh.pallipadi@intel.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'Nakajima, Jun'" <jun.nakajima@intel.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'James Cleverdon'" <jamesclv@us.ibm.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] (0/7) Finish moving NUMA-Q into subarch, cleanup
Message-ID: <246470000.1042482601@titus>
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C022BD8E5@usslc-exch-4.slc.unisys.com>
References: <3FAD1088D4556046AEC48D80B47B478C022BD8E5@usslc-exch-4.slc.unisys.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I ran into a couple places where CONFIG_X86_NUMA is still there (replaced
> now with CONFIG_X86_NUMAQ), which disables following defines:

Yeah, I saw those the other day. Should probably be replaced with 
CONFIG_NUMA ... I'll tweak them once I get the last dribbles of Summit
pushed out to Linus.

Thanks,

M.


