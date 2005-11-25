Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751486AbVKYW1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbVKYW1c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 17:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbVKYW1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 17:27:32 -0500
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:21102 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751486AbVKYW1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 17:27:31 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Marc Koschewski <marc@osknowledge.org>
Subject: Re: Mouse issues in -mm
Date: Fri, 25 Nov 2005 17:27:24 -0500
User-Agent: KMail/1.8.3
Cc: Frank Sorenson <frank@tuxrocks.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Harald Welte <laforge@netfilter.org>
References: <20051123033550.00d6a6e8.akpm@osdl.org> <200511232226.44459.dtor_core@ameritech.net> <20051124094019.GA6788@stiffy.osknowledge.org>
In-Reply-To: <20051124094019.GA6788@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511251727.24630.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 November 2005 04:40, Marc Koschewski wrote:
> I don't know why my touchpad is not listed. I have one and it perfectly
> works with X (same pointer as the mouse which is a Microsoft USB Wheel Mouse'
> attached to PS/2 using an appropriate adapter.
>

[I dropped netdev list from CC...] 

You have a Dell Inspiron, right? On Inspirons (and Latitudes) mouse
connected to external PS/2 port completely shadoes touchpad making
it invisible to the kernel.
-- 
Dmitry
