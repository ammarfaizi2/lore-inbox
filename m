Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbVKSJ1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbVKSJ1l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 04:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbVKSJ1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 04:27:41 -0500
Received: from mx1.suse.de ([195.135.220.2]:61870 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750956AbVKSJ1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 04:27:40 -0500
From: Neil Brown <neilb@suse.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Date: Sat, 19 Nov 2005 20:27:30 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17278.61442.424759.803762@cse.unsw.edu.au>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Mark Vojkovich <mvojkovi@XFree86.Org>,
       Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
       Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/3] Uinput update
In-Reply-To: message from Dmitry Torokhov on Friday November 18
References: <20051119043840.747384000.dtor_core@ameritech.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday November 18, dtor_core@ameritech.net wrote:
> Hi,
> 
> The following patches update uinput driver to perform dynamic input
> allocation, add some locking and ioctl to allow setting EV_SW.
> 
> Any testing will be greatly appreciated.

Well it certainly solved the problems I was having with uinput,
Thanks!

NeilBrown
