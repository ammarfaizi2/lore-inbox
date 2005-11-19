Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbVKSHq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbVKSHq7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 02:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbVKSHq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 02:46:59 -0500
Received: from styx.suse.cz ([82.119.242.94]:28861 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750953AbVKSHq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 02:46:58 -0500
Date: Sat, 19 Nov 2005 08:46:46 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Mark Vojkovich <mvojkovi@XFree86.Org>,
       Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
       Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>,
       Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/3] Uinput update
Message-ID: <20051119074646.GC12551@midnight.suse.cz>
References: <20051119043840.747384000.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051119043840.747384000.dtor_core@ameritech.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 11:38:40PM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> The following patches update uinput driver to perform dynamic input
> allocation, add some locking and ioctl to allow setting EV_SW.
> 
> Any testing will be greatly appreciated.

Thanks for the patches!

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
