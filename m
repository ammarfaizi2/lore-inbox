Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVFMJFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVFMJFb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 05:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVFMJFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 05:05:30 -0400
Received: from odin2.bull.net ([192.90.70.84]:60838 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S261438AbVFMJFZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 05:05:25 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Eugeny S. Mints" <emints@ru.mvista.com>
In-Reply-To: <Pine.LNX.4.44.0506090932300.27999-100000@dhcp153.mvista.com>
References: <Pine.LNX.4.44.0506090932300.27999-100000@dhcp153.mvista.com>
Content-Type: text/plain; charset=iso-8859-15
Organization: BTS
Message-Id: <1118652783.10717.66.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Mon, 13 Jun 2005 10:53:04 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 09/06/2005 à 18:34, Daniel Walker a écrit :
> On Thu, 9 Jun 2005, Serge Noiraud wrote:
> 
> > Same problem with 48-04 and 48-05
> > It works great with rc6 without RT patch.
> > Here is my .config
> > The cmdline options at boot time are :
> > #more /proc/cmdline
> > BOOT_IMAGE=2.6.12rc6RTV0.7.4805 ro root=306 console=ttyS0 console=tty1 \
> > acpi=force apm=smp resume=/dev/hda5
> 
> 
> 
> Does this patch get you any further?
> 
Sorry for the delay , I was out of my office.
I tested 48-19 and no more problem.
So, is it useful to test it anymore ?
Do you fix it another way ?

