Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUCaNjZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 08:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbUCaNjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 08:39:25 -0500
Received: from [80.72.36.106] ([80.72.36.106]:15788 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261943AbUCaNjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 08:39:24 -0500
Date: Wed, 31 Mar 2004 15:39:19 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: wolk-devel@lists.sourceforge.net, Alan Stern <stern@rowland.harvard.edu>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, speedtouch@ml.free.fr
Subject: Re: [linux-usb-devel] speedtouch and/or USB problem (2.6.4-WOLK2.3)
In-Reply-To: <200403311121.27731@WOLK>
Message-ID: <Pine.LNX.4.58.0403311533060.7843@alpha.polcom.net>
References: <Pine.LNX.4.44L0.0403271851040.2209-100000@ida.rowland.org>
 <200403311121.27731@WOLK>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2004, Marc-Christian Petersen wrote:

> On Sunday 28 March 2004 00:51, Alan Stern wrote:
> 
> Hi Grzegorz,
> 
> > > When running modem_run on 2.6.4-WOLK2.3 it locks in D state on one of USB
> > > ioctls. It works at least on 2.6.2-rc2. I have no idea what causes this
> > > bug so I sent it to all lists.
> > > Please help if you can.
> > > Grzegorz Kulewski
> 
> > Try applying this patch:
> > http://marc.theaimsgroup.com/?l=linux-usb-devel&m=108016447231291&q=raw
> 
> Did this help Grzegorz?

I will probably compile new kernel before friday. I had some urgent tasks 
to solve in normal differetial equations on my university :).

But this seems the right solution/workaround for the problem and probably 
should work (of course I do not know if there are other bugs preventing 
modem_run from continuing :)).

I will post the anwser as soon as possible.


thanks once more

Grzegorz

