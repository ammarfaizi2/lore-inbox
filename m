Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268072AbUH1VVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268072AbUH1VVz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 17:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266887AbUH1VUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 17:20:34 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:16521 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267974AbUH1VRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 17:17:42 -0400
Date: Sat, 28 Aug 2004 22:17:17 +0100
From: Dave Jones <davej@redhat.com>
To: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm Kconfig fixes
Message-ID: <20040828211717.GF6301@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200408280309.i7S39PPv000756@hera.kernel.org> <20040828210533.GD6301@redhat.com> <20040828221345.A11901@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040828221345.A11901@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 10:13:45PM +0100, Christoph Hellwig wrote:
 > On Sat, Aug 28, 2004 at 10:05:33PM +0100, Dave Jones wrote:
 > > Even if not,  I think I'd actually prefer a whitelist of drivers that *do*
 > > support agpgart in the Kconfig, than the above which needs to be added to
 > > all the time.  Something like if X86 && ALPHA && IA64 should cover it currently.
 > 
 > PPC

Bah, I *knew* I'd miss one. I even read the Kconfig twice after missing IA64.
I suck. I still stand by my claim that it would look better though.

		Dave

