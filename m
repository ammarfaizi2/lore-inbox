Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbSLTLQr>; Fri, 20 Dec 2002 06:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261582AbSLTLQr>; Fri, 20 Dec 2002 06:16:47 -0500
Received: from holomorphy.com ([66.224.33.161]:40645 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261615AbSLTLQq>;
	Fri, 20 Dec 2002 06:16:46 -0500
Date: Fri, 20 Dec 2002 03:24:01 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Martin Bligh <mbligh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH][2.4]  generic cluster APIC support for systems with more than 8 CPUs
Message-ID: <20021220112401.GB7644@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Christoph Hellwig <hch@infradead.org>,
	James Cleverdon <jamesclv@us.ibm.com>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Martin Bligh <mbligh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"Mallick, Asit K" <asit.k.mallick@intel.com>,
	"Saxena, Sunil" <sunil.saxena@intel.com>
References: <C8C38546F90ABF408A5961FC01FDBF1912E18E@fmsmsx405.fm.intel.com> <200212191804.55194.jamesclv@us.ibm.com> <20021220080050.A23184@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021220080050.A23184@infradead.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2002 at 06:04:55PM -0800, James Cleverdon wrote:
>> A generic patch should also support Unisys' new box, the ES7000 or
>> some such.

On Fri, Dec 20, 2002 at 08:00:50AM +0000, Christoph Hellwig wrote:
> That box needs more changes than just the apic setup.  Unfortunately
> unisys thinks they shouldn't send their patches to lkml, but when you see
> them e.g. in the suse tree it's a bit understandable that they don't want
> anyone to really see their mess :)
> And btw, the box isn't that new, but three years ago or so when they first
> showed it on cebit they even refused to talk about linux due to their
> restrictive agreements with Microsoft..

Kevin, you're the only lkml-posting contact point I know of within Unisys.
Is there any chance you could flag down some of the ia32 crew there for
some commentary on this stuff? (or do so yourself if you're in it)


Thanks,
Bill
