Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267235AbTBQSDT>; Mon, 17 Feb 2003 13:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267236AbTBQSDT>; Mon, 17 Feb 2003 13:03:19 -0500
Received: from holomorphy.com ([66.224.33.161]:56206 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267235AbTBQSDT>;
	Mon, 17 Feb 2003 13:03:19 -0500
Date: Mon, 17 Feb 2003 10:12:21 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: asm-i386/numaq.h fixes
Message-ID: <20030217181221.GO29983@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <20030217075107.GA14324@holomorphy.com> <4540000.1045501282@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4540000.1045501282@[10.10.2.4]>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> As can be seen from:
>> http://www-3.ibm.com/software/data/db2/benchmarks/050300.html
>> MAX_NUMNODES is 16 on NUMA-Q, not 8.

On Mon, Feb 17, 2003 at 09:01:25AM -0800, Martin J. Bligh wrote:
> Not unless we have NUM_CPUS > BITS_PER_LONG it's not. Please don't change that.

I already wrote it, with the real honest-to-god rotorooting of arch/i386/


-- wli
