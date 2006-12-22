Return-Path: <linux-kernel-owner+w=401wt.eu-S1752437AbWLVT5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbWLVT5w (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 14:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbWLVT5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 14:57:52 -0500
Received: from nlpi015.sbcis.sbc.com ([207.115.36.44]:46546 "EHLO
	nlpi015.sbcis.sbc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbWLVT5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 14:57:51 -0500
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Dec 2006 14:57:51 EST
X-ORBL: [67.117.73.34]
Date: Fri, 22 Dec 2006 11:51:16 -0800
From: Tony Lindgren <tony@atomide.com>
To: Komal Shah <komal.shah802003@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       Vladimir Ananiev <vovan888@gmail.com>
Subject: Re: omap compilation fixes
Message-ID: <20061222195115.GC2449@atomide.com>
References: <20061222105521.GA23683@elf.ucw.cz> <3a5b1be00612220335l4779089egae0d3270a7c9cd5f@mail.gmail.com> <20061222115116.GA961@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222115116.GA961@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Russell King <rmk+lkml@arm.linux.org.uk> [061222 03:51]:
> On Fri, Dec 22, 2006 at 01:35:31PM +0200, Komal Shah wrote:
> > On 12/22/06, Pavel Machek <pavel@ucw.cz> wrote:
> > >Hi!
> > >
> > >This is not yet complete set. set_map() is missing in latest kernels.
> > >
> > >Fix DECLARE_WORK()-change-related compilation problems. Please apply,
> > >
> > >Signed-off-by: Pavel Machek <pavel@suse.cz>
> > >
> > 
> > Please check linux-omap-open-source mailing list. Some of the build
> > breakage patches are already posted regarding to latest kernel sync
> > up.
> > 
> > http://linux.omap.com/pipermail/linux-omap-open-source
> 
> There are a set of omap patches in the patch system, but they were too
> late for me to merge within the 2 week window - there were additional
> delays caused by the accidental attempt to merge the silly ATAG_BOARD
> stuff which I had previously refused.
> 
> Tony needs to either create a git tree containing strictly just fixes
> suitable for -rc kernels, or submit them as individual patches.

Yeah, I'll put together a set of fixes shortly, and will keep the
larger merge set for post 2.6.20.

Regards,

Tony
