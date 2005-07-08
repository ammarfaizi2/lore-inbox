Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262771AbVGHTCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbVGHTCr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbVGHTCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:02:47 -0400
Received: from fmr24.intel.com ([143.183.121.16]:50146 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262771AbVGHTCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:02:45 -0400
Date: Fri, 8 Jul 2005 12:01:43 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>, akpm@osdl.org,
       Andi Kleen <ak@suse.de>, "David S. Miller" <davem@davemloft.net>,
       systemtap@sources.redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [5/6 PATCH] Kprobes : Prevent possible race conditions ia64 changes
Message-ID: <20050708120143.A6837@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20050707101833.GI12106@in.ibm.com> <20050707190645.A29253@unix-os.sc.intel.com> <20050708111045.GA15871@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050708111045.GA15871@in.ibm.com>; from prasanna@in.ibm.com on Fri, Jul 08, 2005 at 04:40:45PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2005 at 04:40:45PM +0530, Prasanna S Panchamukhi wrote:
> Hi Anil,
> 
> I have updated the patch as per your comments to move routines
> from jprobes.S to .kprobes.text section.
> 
> Please let me know if you any issues.
Looks fine and tested it too on IA64 Tiger4 box and works as intened.
Acked-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>

