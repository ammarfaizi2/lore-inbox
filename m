Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316837AbSGSR21>; Fri, 19 Jul 2002 13:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316935AbSGSR21>; Fri, 19 Jul 2002 13:28:27 -0400
Received: from holomorphy.com ([66.224.33.161]:9360 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316837AbSGSR20>;
	Fri, 19 Jul 2002 13:28:26 -0400
Date: Fri, 19 Jul 2002 10:31:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Guillaume Boissiere <boissiere@adiglobal.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
Message-ID: <20020719173126.GZ1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Guillaume Boissiere <boissiere@adiglobal.com>,
	linux-kernel@vger.kernel.org
References: <3D361091.13618.16DC46FB@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D361091.13618.16DC46FB@localhost>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 12:49:21AM -0400, Guillaume Boissiere wrote:
> Ongoing work:

My projects:

(1) parallelizing pagefaults
(2) parallelizing page replacement
(3) allocating pte_chains from highmem
(4) deferred coalescing page allocation
(5) removing embedding waitqueue heads / hashing all waitqueues
(6) removing the global tasklist and all iterations over it



Cheers,
Bill
