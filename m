Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264108AbUFCUhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbUFCUhj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 16:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbUFCUhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 16:37:39 -0400
Received: from uni03du.unity.ncsu.edu ([152.1.13.103]:63116 "EHLO
	uni03du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S264108AbUFCUhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 16:37:36 -0400
From: jlnance@unity.ncsu.edu
Date: Thu, 3 Jun 2004 16:37:28 -0400
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040603203728.GA17239@ncsu.edu>
References: <20040602205025.GA21555@elte.hu> <Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org> <20040602211714.GB29687@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602211714.GB29687@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 11:17:14PM +0200, Arjan van de Ven wrote:
> On Wed, Jun 02, 2004 at 02:13:13PM -0700, Linus Torvalds wrote:
> > 
> > Just out of interest - how many legacy apps are broken by this? I assume 
> > it's a non-zero number, but wouldn't mind to be happily surprised.
> 
> based on execshield in FC1.. about zero.

FWIW, applix runs fine on FC1 (well, after you install the necessary
libraries.)  This is probably about the oldest binary-only legacy app
for linux.  The date on the executable is Jun 1996.

Thanks,

Jim
