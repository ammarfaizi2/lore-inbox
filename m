Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbSLQPuD>; Tue, 17 Dec 2002 10:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264625AbSLQPuD>; Tue, 17 Dec 2002 10:50:03 -0500
Received: from holomorphy.com ([66.224.33.161]:9656 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264610AbSLQPuD>;
	Tue, 17 Dec 2002 10:50:03 -0500
Date: Tue, 17 Dec 2002 07:57:30 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, gh@us.ibm.com
Subject: Re: 2.5.52-mjb1 (scalability / NUMA patchset)
Message-ID: <20021217155730.GC1922@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, gh@us.ibm.com
References: <19270000.1038270642@flay> <134580000.1039414279@titus> <32230000.1039502522@titus> <568990000.1040112629@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568990000.1040112629@titus>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 12:10:29AM -0800, Martin J. Bligh wrote:
> The patchset contains mainly scalability and NUMA stuff, and
> anything else that stops things from irritating me. It's meant
> to be pretty stable, not so much a testing ground for new stuff.
> I'd be very interested in feedback from other people running
> large SMP or NUMA boxes.
> http://www.aracnet.com/~fletch/linux/2.5.52/patch-2.5.52-mjb1.bz2

BTW, the mem_map initialization stuff has been pretty well shaken down,
so it's safe to slurp that up now.


Bill
