Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314641AbSEBQcw>; Thu, 2 May 2002 12:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314642AbSEBQcv>; Thu, 2 May 2002 12:32:51 -0400
Received: from holomorphy.com ([66.224.33.161]:55510 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314641AbSEBQcu>;
	Thu, 2 May 2002 12:32:50 -0400
Date: Thu, 2 May 2002 09:31:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: Andrea Arcangeli <andrea@suse.de>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
        Jesse Barnes <jbarnes@sgi.com>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <20020502163135.GI32767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>,
	Andrea Arcangeli <andrea@suse.de>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
	Jesse Barnes <jbarnes@sgi.com>
In-Reply-To: <20020426192711.D18350@flint.arm.linux.org.uk> <E171aOa-0001Q6-00@starship> <20020429153500.B28887@dualathlon.random> <E172K9n-0001Yv-00@starship> <20020501042341.G11414@dualathlon.random> <20020501180547.GA1212440@sgi.com> <20020502011750.M11414@dualathlon.random> <20020502002010.GA14243@krispykreme> <20020502030113.Q11414@dualathlon.random> <20020502152825.GE10495@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2002 at 01:28:25AM +1000, Anton Blanchard wrote:
> Also when we do hotplug memory support will discontigmem be able to
> efficiently handle memory turning up all over the place in the memory
> map?

Would the flip side of that coin perhaps be implementing a way to be a
good logically partitioned citizen and cooperatively offline memory?


Cheers,
Bill
