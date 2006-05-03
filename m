Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWECSbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWECSbt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 14:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWECSbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 14:31:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27151 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750706AbWECSbt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 14:31:49 -0400
Date: Wed, 3 May 2006 18:31:37 +0000
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, Michael Helmling <supermihi@web.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] New, yet unsupported USB-Ethernet adaptor
Message-ID: <20060503183136.GA4404@ucw.cz>
References: <200605022002.15845.supermihi@web.de> <200605021509.17050.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605021509.17050.david-b@pacbell.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I bought an USB-Ethernet adaptor from delock (www.delock.de) and found it was 
> > not supported by linux from the vendor. So I played a little with lsusb and 
> > found it uses a MCS7830 chip from MosChip semiconductor (moschip.com). On 
> > their homepage I found a driver but it only was a precompiled Fedora4 module. 
> > So I wrote them an email and they sent me the whole source code for the 
> > module...
> >
> > Would be nice to see this supported in further kernel releases.
> > The sourcecode can be found at ftp://supermihi.myftp.org
> 
> Was it you who removed the copyrights from the "usbnet" driver and
> changed the author assertion to one "M Subrahmanya Srihdar" ??
> I'm guessing the latter; the www.moschip.com site implies that
> its engineering HW is in India.
> 
> Either way, blatant plagiarism and theft of copyright is unlikely
> to get into upstream kernels.

Well, I suspect that poor soul did not know what (s)he was doing. They
are clearly trying to do the right thing... just paste back original
copyrights and be done with it.
							Pavel
-- 
Thanks, Sharp!
