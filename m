Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSGYNC0>; Thu, 25 Jul 2002 09:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSGYNC0>; Thu, 25 Jul 2002 09:02:26 -0400
Received: from ns.suse.de ([213.95.15.193]:23049 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S312938AbSGYNC0>;
	Thu, 25 Jul 2002 09:02:26 -0400
Date: Thu, 25 Jul 2002 15:05:39 +0200
From: Dave Jones <davej@suse.de>
To: Shawn Starr <spstarr@sh0n.net>
Cc: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
Subject: Re: MTRR Problems - 2.4.19-rc3
Message-ID: <20020725150538.U16446@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Shawn Starr <spstarr@sh0n.net>, linux-kernel@vger.kernel.org,
	rgooch@atnf.csiro.au
References: <200207250303.20809.spstarr@sh0n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200207250303.20809.spstarr@sh0n.net>; from spstarr@sh0n.net on Thu, Jul 25, 2002 at 03:03:20AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 03:03:20AM -0400, Shawn Starr wrote:
 > mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
 > mtrr: detected mtrr type: Intel
 > mtrr: no MTRR for e0000000,4000000 found
 > 
 > Someone explain how an AMD Motherboard is Intel type? ;-) 

The Athlon implemented Intel style MTRRs.
There is no bug there.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
