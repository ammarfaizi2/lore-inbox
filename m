Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316979AbSFWGgc>; Sun, 23 Jun 2002 02:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316981AbSFWGgb>; Sun, 23 Jun 2002 02:36:31 -0400
Received: from holomorphy.com ([66.224.33.161]:21959 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316979AbSFWGga>;
	Sun, 23 Jun 2002 02:36:30 -0400
Date: Sat, 22 Jun 2002 23:35:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Christopher E. Brown" <cbrown@woods.net>
Cc: Andreas Dilger <adilger@clusterfs.com>,
       "Griffiths, Richard A" <richard.a.griffiths@intel.com>,
       "'Andrew Morton'" <akpm@zip.com.au>, mgross@unix-os.sc.intel.com,
       "'Jens Axboe'" <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: ext3 performance bottleneck as the number of spindles gets large
Message-ID: <20020623063543.GH25360@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Christopher E. Brown" <cbrown@woods.net>,
	Andreas Dilger <adilger@clusterfs.com>,
	"Griffiths, Richard A" <richard.a.griffiths@intel.com>,
	'Andrew Morton' <akpm@zip.com.au>, mgross@unix-os.sc.intel.com,
	'Jens Axboe' <axboe@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	lse-tech@lists.sourceforge.net
References: <20020623043310.GL22411@clusterfs.com> <Pine.LNX.4.44.0206222350070.30350-100000@spruce.woods.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206222350070.30350-100000@spruce.woods.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 23, 2002 at 12:00:01AM -0600, Christopher E. Brown wrote:
> However, multiple busses are *rare* on x86.  There are alot of chained
> busses via PCI to PCI bridge, but few systems with 2 or more PCI
> busses of any type with parallel access to the CPU.

NUMA-Q has them.


Cheers,
Bill
