Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264675AbUEEOH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264675AbUEEOH2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 10:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264680AbUEEOH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 10:07:28 -0400
Received: from fmr03.intel.com ([143.183.121.5]:39655 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S264675AbUEEOH0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 10:07:26 -0400
Date: Wed, 5 May 2004 07:07:04 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org, anil.s.keshavamurthy@intel.com,
       pj@sgi.com
Subject: Re: (resend) take3: Updated CPU Hotplug patches for IA64 (pj blessed) Patch [6/7]
Message-ID: <20040505070704.A21637@unix-os.sc.intel.com>
References: <20040504211755.A13286@unix-os.sc.intel.com> <20040504225907.6c2fe459.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040504225907.6c2fe459.akpm@osdl.org>; from akpm@osdl.org on Tue, May 04, 2004 at 10:59:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 10:59:07PM -0700, Andrew Morton wrote:
> Ashok Raj <ashok.raj@intel.com> wrote:
> >
> >  Name: cpu_present_map.patch
> 
> This does not play happily with the sched_domains patches.
> 
> 
> I'll drop this final patch.  Please reissue it against next -mm.  Thanks.

Thanks, i will rework the patch and resend soon.

Cheers,
Ashok
-- Linux Core Software Group
