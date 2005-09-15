Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030422AbVIOOll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030422AbVIOOll (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 10:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbVIOOll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 10:41:41 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:56508 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1030422AbVIOOll
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 10:41:41 -0400
Subject: Re: [patch 09/28] Input: convert net/bluetooth to dynamic
	input_dev allocation
From: Marcel Holtmann <marcel@holtmann.org>
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Hannes Reinecke <hare@suse.de>
In-Reply-To: <d120d50005091507225659868e@mail.gmail.com>
References: <20050915070131.813650000.dtor_core@ameritech.net>
	 <20050915070302.931769000.dtor_core@ameritech.net>
	 <1126770894.28510.10.camel@station6.example.com>
	 <d120d50005091507225659868e@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 15 Sep 2005 16:41:50 +0200
Message-Id: <1126795310.3505.47.camel@station6.example.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> > > Input: convert net/bluetooth to dynamic input_dev allocation
> > >
> > > This is required for input_dev sysfs integration
> > >
> > > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> > 
> > on the condition your stuff got merged, then this patch is ok with me.
> > 
> > Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> > 
> 
> I was planning on getting patch 8 (preparation patch) into kernel ASAP
> and then just sending individual subsystem patches to maintainers and
> Andrew so they can merge at their leisure (but don't wait for too long
> ;))

I have no problem with you submitting the changes. If Vojtech is fine
with the proposed way, I would say that we get all of these changes into
mainline now. The device model integration is long overdue.

Regards

Marcel


