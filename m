Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267291AbTAQJlF>; Fri, 17 Jan 2003 04:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267448AbTAQJlF>; Fri, 17 Jan 2003 04:41:05 -0500
Received: from holomorphy.com ([66.224.33.161]:39061 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267291AbTAQJlE>;
	Fri, 17 Jan 2003 04:41:04 -0500
Date: Fri, 17 Jan 2003 01:49:56 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.58-mjb2 (scalability / NUMA patchset)
Message-ID: <20030117094956.GF940@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	lse-tech <lse-tech@lists.sourceforge.net>
References: <821470000.1041579423@titus> <214500000.1041821919@titus> <676880000.1042101078@titus> <922170000.1042183282@titus> <437220000.1042531505@titus> <190030000.1042787514@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <190030000.1042787514@titus>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2003 at 11:11:54PM -0800, Martin J. Bligh wrote:
> Speed up page init on boot (Bill Irwin)
> local_pgdat					Bill Irwin
> 	Move the pgdat structure into the remapped space with lmem_map

Any chance you could push these Linus-ward? akpm appears to have
lost the intestinal fortitude to carry NUMA-Q/Summit -specific stuff
himself, which is fine, I'd just rather not see these lost in the
shuffle, esp. as a day or two was burned on each.


Thanks,
Bill
