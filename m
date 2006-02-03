Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945910AbWBCTWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945910AbWBCTWu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945912AbWBCTWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:22:50 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:54285 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1945910AbWBCTWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:22:49 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: WLAN drivers
Date: Fri, 3 Feb 2006 19:22:52 +0000
User-Agent: KMail/1.9.1
Cc: takis.issaris@uhasselt.be, linux-kernel@vger.kernel.org
References: <1138969138.8434.26.camel@localhost.localdomain> <mailman.1138977902.23981.linux-kernel2news@redhat.com> <20060203111423.17275a33.zaitcev@redhat.com>
In-Reply-To: <20060203111423.17275a33.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602031922.52769.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 February 2006 19:14, Pete Zaitcev wrote:
> On Fri, 3 Feb 2006 12:35:30 +0000, Alistair John Strachan 
<s0348365@sms.ed.ac.uk> wrote:
> > > And now the reason I'm sending this to this mailing list: Which
> > > wireless network cards are you all using and which ones would you
> > > recommend? Is anyone using USB wireless network cards (without using
> > > ndiswrapper)?
> >
> > In my experience, you're simply best going to either http://prism54.org/
> > (if you can find one still)
>
> You can't get a fullmac card anymore, but softmac is still available
>  http://www.cdw.com/shop/products/default.aspx?EDC=543916
> It's a gen1, too.
>
> > Keywords for _modern_ Linux supported wireless chipsets are still (to my
> > knowledge) atheros, atmel, prism54, and most recently broadcom, though
> > that support is currently immature.
>
> Intel is the king, dude. Get a 2200. Uses in-tree drivers, too.

I agree, but this:

a)	Still uses proprietary firmware.
b)	Is made only in mini-pci versions (I think?).

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
