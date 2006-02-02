Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWBBRnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWBBRnG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 12:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWBBRnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 12:43:05 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:55992 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750758AbWBBRnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 12:43:03 -0500
Date: Thu, 2 Feb 2006 11:42:27 -0600
From: Jack Steiner <steiner@sgi.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       "Brown, Len" <len.brown@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
       Bob Picco <bob.picco@hp.com>, Paul Jackson <pj@sgi.com>,
       Andy Whitcroft <apw@shadowen.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, ACPI-ML <linux-acpi@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>
Subject: Re: [Patch:002/004] Unify pxm_to_node id ver.2. (for ia64)
Message-ID: <20060202174227.GA960@sgi.com>
References: <20060201205233.41EA.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060201205233.41EA.Y-GOTO@jp.fujitsu.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 09:36:39PM +0900, Yasunori Goto wrote:
> This is to use generic pxm_to_node() function instead of
> old pxm_to_nid_map for ia64. And remove old definition.
> 

I applied the patch & booted on a couple of SN systems.
No problem...


-- 
Jack

