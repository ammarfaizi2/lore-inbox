Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVCUMm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVCUMm7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 07:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVCUMm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 07:42:59 -0500
Received: from styx.suse.cz ([82.119.242.94]:61614 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261777AbVCUMm5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 07:42:57 -0500
Date: Mon, 21 Mar 2005 13:44:07 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kenan Esau <kenan.esau@conan.de>
Cc: harald.hoyer@redhat.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
Message-ID: <20050321124407.GA1762@ucw.cz>
References: <20050217194217.GA2458@ucw.cz> <1108817681.5774.44.camel@localhost> <20050219131639.GA4922@ucw.cz> <1108973216.5774.72.camel@localhost> <20050224090338.GA3699@ucw.cz> <1109664709.18617.10.camel@localhost> <20050301120839.GA5720@ucw.cz> <1110180436.3444.17.camel@localhost> <20050307073406.GA2026@ucw.cz> <1110893143.4777.31.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110893143.4777.31.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 02:25:42PM +0100, Kenan Esau wrote:
> Here is a new version of the patch:
> 	- minimal changes
> 	- reintroduced DMI-probing
> 
> I had a look at the synaptic-sources to see how the pass-through-mode is
> implemented. We'll see if something similar to this also works with the
> lifebook.

Thanks, I applied this version of the patch to my tree. It'll appear in
next -mm, and in 2.6.13.

> I received a request from a user who has a Panasonic CF-29. It also
> seems to have the same Touchscreen hardware like the lifebook. But it
> doesn't seem to work as expected. Can someone get hold of a CF-29 and
> test the psmouse-patch with it?

No, I don't have any ToughBooks nearby.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
