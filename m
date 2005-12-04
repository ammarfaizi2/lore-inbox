Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbVLDBlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbVLDBlH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 20:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbVLDBlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 20:41:07 -0500
Received: from smtp114.sbc.mail.re2.yahoo.com ([68.142.229.91]:42100 "HELO
	smtp114.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751302AbVLDBlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 20:41:05 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <greg@kroah.com>
Subject: Re: Golden rule: don't break userland (was Re: RFC: Starting a stable kernel series off the 2.6 kernel)
Date: Sat, 3 Dec 2005 20:40:59 -0500
User-Agent: KMail/1.8.3
Cc: Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@stusta.de>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       James Bottomley <James.Bottomley@steeleye.com>
References: <20051203135608.GJ31395@stusta.de> <4391E764.7050704@pobox.com> <20051203203418.GA4283@kroah.com>
In-Reply-To: <20051203203418.GA4283@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512032041.00594.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 December 2005 15:34, Greg KH wrote:
> And in the future, the driver/class model changes we are going to be
> doing (see http://lwn.net/Articles/162242/ for more details on this),
> will be going to great lengths to prevent anything in userspace from
> breaking.

It is usually considered a bad netiquette to cross-post in public and
subscription-only lists. I wonder if pointing to subscription-only
service to get the feeling about planned driver core changes is a good
idea. I would expect it be stated here or on hotplug list but don't
recall anything interesting in the last couple of weeks. Is there a
driver core mailing list I need to subscribe?

-- 
Dmitry
