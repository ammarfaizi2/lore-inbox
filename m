Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWCVWph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWCVWph (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWCVWpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:45:35 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:18064 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964812AbWCVWpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:45:08 -0500
Date: Wed, 22 Mar 2006 14:45:05 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, clameter@sgi.com, mm-commits@vger.kernel.org
Subject: Re: +
 add-gfp-flag-__gfp_policy-to-control-policies-and-cpusets-redirection.patch
 added to -mm tree
Message-Id: <20060322144505.d75cca83.pj@sgi.com>
In-Reply-To: <200603222154.k2MLsYu5023582@shell0.pdx.osdl.net>
References: <200603222154.k2MLsYu5023582@shell0.pdx.osdl.net>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> GFP_KERNEL does not have __GFP_POLICY set.  Meaning that page allocations
> with GFP_KERNEL are no longer subject to cpusets and policy constraints. 

I do not (yet anyway) ack this change.

Please don't send it onto Linus until I have a chance to review it.

If anyone lurking has concerns with or insights into the value of this
change, I'd welcome their comments.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
