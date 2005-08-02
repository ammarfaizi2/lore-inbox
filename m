Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVHBLqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVHBLqv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 07:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVHBLqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 07:46:51 -0400
Received: from gw.alcove.fr ([81.80.245.157]:61374 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S261495AbVHBLqu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 07:46:50 -0400
Subject: Re: powerbook power-off and 2.6.13-rc[3,4]
From: Stelian Pop <stelian@popies.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Antonio-M. Corbi Bellot" <antonio.corbi@ua.es>,
       debian-powerpc@lists.debian.org
In-Reply-To: <42EF5B4E.6090101@sipsolutions.net>
References: <1122904460.6491.41.camel@localhost.localdomain>
	 <1122905228.6881.9.camel@localhost>
	 <1122907136.31350.45.camel@localhost.localdomain>
	 <20050802111754.GC1390@elf.ucw.cz>  <42EF5B4E.6090101@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Date: Tue, 02 Aug 2005 13:42:31 +0200
Message-Id: <1122982951.4652.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 02 août 2005 à 13:38 +0200, Johannes Berg a écrit :
> Pavel Machek wrote:
> 
> >Can you try without USB?
> >
> Not really. The keyboard is USB, and there's no PS/2 connector. I guess 
> I maybe could do it via a timer, unload the modules and then have it 
> shut down afterwards...

I'll build a kernel without USB and drive the laptop over the net and
see what happens.

> > With USB but without experimental
> >CONFIG_USB_SUSPEND?
> >  
> >
> I don't have USB_SUSPEND enabled, IIRC (don't have the PB with me, but 
> I'm pretty sure I checked this yesterday. If you don't hear back, assume 
> it wasn't enabled)

I don't have USB_SUSPEND enabled.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

