Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVHBBac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVHBBac (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 21:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVHBBac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 21:30:32 -0400
Received: from fmr17.intel.com ([134.134.136.16]:47578 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261355AbVHBBa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 21:30:28 -0400
Date: Tue, 2 Aug 2005 09:22:10 +0800
From: "Wang, Zhenyu" <zhenyu.z.wang@intel.com>
To: Roger Heflin <rheflin@atipa.com>
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: ECC Support in Linux
Message-ID: <20050802012210.GA26029@zhen-devel.sh.intel.com>
Mail-Followup-To: Roger Heflin <rheflin@atipa.com>,
	'linux-kernel' <linux-kernel@vger.kernel.org>
References: <1122770777.5473.1.camel@mindpipe> <EXCHG2003DbH8J0sca0000007f8@EXCHG2003.microtech-ks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EXCHG2003DbH8J0sca0000007f8@EXCHG2003.microtech-ks.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005.08.01 13:03:34 +0000, Roger Heflin wrote:
>  
> On the newer Intels I have not found any useable ECC support
> is there any in the kernels?

For ia32, not in kernel now, see http://bluesmoke.sf.net
For ia64, kernel already have support. 

> 
> I can test a variety of hardware if someone needs it, and can
> probably even come up with some test memory that will generate ecc
> errors.
> 

Good! bluesmoke now has many advanced server support, you can help
to test those drivers. Pls subscribe bluesmoke's ML.

thanks
-zhen
