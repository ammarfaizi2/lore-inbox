Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267514AbUJGSFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267514AbUJGSFI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267551AbUJGSBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:01:40 -0400
Received: from jade.aracnet.com ([216.99.193.136]:33716 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267514AbUJGR7b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 13:59:31 -0400
Date: Thu, 07 Oct 2004 10:56:43 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Matthew E Tolentino <matthew.e.tolentino@intel.com>,
       Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Luck, Tony" <tony.luck@intel.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>
Subject: Re: [PATCH]  no buddy bitmap patch : intro and includes [0/2]
Message-ID: <1343960000.1097171803@[10.10.2.4]>
In-Reply-To: <1097165419.3625.54.camel@localhost>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB007ED31D6@fmsmsx406.amr.corp.intel.com> <1097163578.3625.43.camel@localhost>  <1260090000.1097164623@[10.10.2.4]> <1097165419.3625.54.camel@localhost>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Makese sense on both counts. Would be nice to add the justification to 
>> the changelog ;-)
> 
> Would you mind running these through your normal set of tests on the
> NUMAQ?  The last time I ran them, I didn't see a performance impact
> either way, and I'd be good to check again.

Makes no difference in performance that I can see.

M.

