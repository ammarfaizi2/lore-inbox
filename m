Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267649AbUIJDYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267649AbUIJDYv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 23:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267685AbUIJDYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 23:24:51 -0400
Received: from ozlabs.org ([203.10.76.45]:10189 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267649AbUIJDYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 23:24:49 -0400
Date: Fri, 10 Sep 2004 13:24:11 +1000
From: Anton Blanchard <anton@samba.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
Message-ID: <20040910032411.GK11358@krispykreme>
References: <16704.52551.846184.630652@cargo.ozlabs.ibm.com> <20040909220040.GM3106@holomorphy.com> <16704.59668.899674.868174@cargo.ozlabs.ibm.com> <20040910000903.GS3106@holomorphy.com> <Pine.LNX.4.58.0409091712270.5912@ppc970.osdl.org> <20040910003505.GG11358@krispykreme> <Pine.LNX.4.58.0409091750300.5912@ppc970.osdl.org> <20040910014228.GH11358@krispykreme> <20040910015040.GI11358@krispykreme> <20040910022204.GA2616@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910022204.GA2616@holomorphy.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Well, there are patches that do this along with other more useful
> things in the works (my spin on this is en route shortly, sorry the
> response was delayed due to a power failure).

OK. I just sent out a minimal fix, hopefully there isnt too much overlap :)

Anton
