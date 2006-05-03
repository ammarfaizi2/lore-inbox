Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWECSd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWECSd6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 14:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWECSd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 14:33:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:28943 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750707AbWECSd6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 14:33:58 -0400
Date: Wed, 3 May 2006 18:33:40 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Michael Helmling <supermihi@web.de>
Cc: linux-usb-devel@lists.sourceforge.net, Andrey Panin <pazke@donpac.ru>,
       David Hollis <dhollis@davehollis.com>,
       David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] New, yet unsupported USB-Ethernet adaptor
Message-ID: <20060503183340.GB4404@ucw.cz>
References: <200605022002.15845.supermihi@web.de> <1146667488.2348.28.camel@dhollis-lnx.sunera.com> <20060503153128.GA31133@pazke.donpac.ru> <200605032014.28734.supermihi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605032014.28734.supermihi@web.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Wed 03-05-06 20:14:28, Michael Helmling wrote:
> On Wednesday 03 May 2006 17:31, Andrey Panin wrote:
> > > What he
> > > should do would be to create a moschip.c that uses usbnet as a support
> > > module - just like asix.c does.  In this file, he can have his sole
> > > Copyright attribution and not have to worry about following
> > > changes/updates to usbnet.  Of course, if he communicated his
> > > development efforts with the community, he would have received all of
> > > this information long ago and we'd likely help shake out bugs in the
> > > code to make it a more robust driver.
> > 
> > IMHO we should do it now. If there is no volunteers, I can try to do it,
> > but it will be my first USB driver, so don't expect results soon.
> > 
> 
> That would be great, I could give you feedback if / how it works.
> But I think someone versed in the GPL should contact moschip to clear things a 
> bit.

No need to pull them into the loop, I'd say. What they done is wrong,
but we can correct it without their help.
							Pavel
-- 
Thanks, Sharp!
