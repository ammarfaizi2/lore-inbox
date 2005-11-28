Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbVK1Les@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVK1Les (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 06:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVK1Les
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 06:34:48 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:63117 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751244AbVK1Les (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 06:34:48 -0500
From: Duncan Sands <duncan.sands@free.fr>
To: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: speedtch driver, 2.6.14.2
Date: Mon, 28 Nov 2005 12:34:44 +0100
User-Agent: KMail/1.8.3
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
References: <200511232125.25254.s0348365@sms.ed.ac.uk> <200511280929.56230.duncan.sands@free.fr> <m3psolum07.fsf@defiant.localdomain>
In-Reply-To: <m3psolum07.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511281234.45023.duncan.sands@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If you unplug the phone line and plug it back in again, does the line
> > resynchronize?  Does the driver detect that the line is back up?
> 
> Sure.

If you turn on CONFIG_USB_DEBUG, enough info should turn up to be able
to work out which urbs are failing.  That would be helpful.

Ciao,

D.
