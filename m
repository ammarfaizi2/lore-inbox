Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030471AbWBHCyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030471AbWBHCyI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 21:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965187AbWBHCyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 21:54:08 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:25771 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S965185AbWBHCyG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 21:54:06 -0500
Date: Tue, 7 Feb 2006 19:54:05 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Keith Owens <kaos@sgi.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Adrian Bunk'" <bunk@stusta.de>, "Luck, Tony" <tony.luck@intel.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let IA64_GENERIC select more stuff
Message-ID: <20060208025405.GA1639@parisc-linux.org>
References: <200602080140.k181eDg20764@unix-os.sc.intel.com> <10378.1139366890@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10378.1139366890@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 01:48:10PM +1100, Keith Owens wrote:
> Blame me for the SMP bit.  I have a dim, distant memory that Intel
> required all IA64 boxes to be SMP, but I could be wrong.  Also it is

The HP zx2000 is a single socket workstation, and you can buy other HP
workstations/servers with only one socket occupied.

