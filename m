Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267431AbUJGRDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267431AbUJGRDa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 13:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267423AbUJGRBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 13:01:21 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:13479 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S267502AbUJGQLN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 12:11:13 -0400
Subject: Re: [PATCH]  no buddy bitmap patch : intro and includes [0/2]
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Matthew E Tolentino <matthew.e.tolentino@intel.com>,
       Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Luck, Tony" <tony.luck@intel.com>,
       Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <1260090000.1097164623@[10.10.2.4]>
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB007ED31D6@fmsmsx406.amr.corp.intel.com>
	 <1097163578.3625.43.camel@localhost>  <1260090000.1097164623@[10.10.2.4]>
Content-Type: text/plain
Message-Id: <1097165419.3625.54.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 07 Oct 2004 09:10:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 08:57, Martin J. Bligh wrote:
> Makese sense on both counts. Would be nice to add the justification to 
> the changelog ;-)

Would you mind running these through your normal set of tests on the
NUMAQ?  The last time I ran them, I didn't see a performance impact
either way, and I'd be good to check again.

-- Dave

