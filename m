Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbVCUXCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVCUXCe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVCUW6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:58:39 -0500
Received: from fmr22.intel.com ([143.183.121.14]:11703 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262184AbVCUW51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:57:27 -0500
Date: Mon, 21 Mar 2005 14:57:16 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: Paul Ionescu <i_p_a_u_l@yahoo.com>
Cc: Rajesh Shah <rajesh.shah@intel.com>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [ACPI] Re: [RFC/Patch 0/12] ACPI based root bridge hot-add
Message-ID: <20050321145716.A7200@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050321203408.74684.qmail@web50205.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050321203408.74684.qmail@web50205.mail.yahoo.com>; from i_p_a_u_l@yahoo.com on Mon, Mar 21, 2005 at 12:34:07PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 12:34:07PM -0800, Paul Ionescu wrote:
> 
> --- Rajesh Shah <rajesh.shah@intel.com> wrote:
> > 
> > No. The current patches only trigger when a _root_ bridge is
> > hot-added, not a PCI to PCI bridge (which is what the docking 
> > station is). The code to support p2p bridge hotplug will benefit
> > from these patches but more code is needed to support that.
> > 
> 
> Thanks for the info.
> Is p2p hotplug in your roadmap (for i386) ?
> Can you please give me an example of a root bridge ?
> 
I believe others are already working on it. I expect to free up
a bit more in a couple of weeks.  If I don't see any patches or
indication of activity by then, I'll work on adding this support
too.

Rajesh
