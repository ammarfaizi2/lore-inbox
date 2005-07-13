Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262544AbVGMD4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbVGMD4w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 23:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbVGMD4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 23:56:46 -0400
Received: from fmr21.intel.com ([143.183.121.13]:59555 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S262544AbVGMD42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 23:56:28 -0400
Date: Tue, 12 Jul 2005 20:56:21 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       prasanna@in.ibm.com
Subject: Re: [PATCH]Kprobes IA64 - Fix race when break hits and kprobe not found
Message-ID: <20050712205620.A9292@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20050712185230.A8528@unix-os.sc.intel.com> <20050712190231.789da83c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050712190231.789da83c.akpm@osdl.org>; from akpm@osdl.org on Tue, Jul 12, 2005 at 07:02:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2005 at 07:02:31PM -0700, Andrew Morton wrote:
> Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com> wrote:
> >
> > This patch applies on top of  "Prasanna S Panchamukhi's" recent postings
> >  Kprobes: Prevent possible race condition ia64 changes
> 
> I am not aware of such a patch.  Your patch hit a reject when I tried to
> apply it to Linus's tree.  So I don't know what's going on..

Andrew,
	I thought you might have applied http://marc.theaimsgroup.com/?l=linux-kernel&m=112082142008250&w=2 hence I generated my patch on top of this.

No problem, I will generate this patch against Linus's tree (as this does not really depend on any other patches) and submit it again in couple of hours. 
Let me know if this is okay.

-thanks,
-Anil
