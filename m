Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbVLVEIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbVLVEIs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbVLVEIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:08:48 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:61887 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964936AbVLVEIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:08:47 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] Input: fix an OOPS in HID driver
Date: Wed, 21 Dec 2005 23:08:43 -0500
User-Agent: KMail/1.8.3
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200512162131.04544.dtor_core@ameritech.net> <200512171142.54758.dtor_core@ameritech.net> <20051222001501.GI3917@stusta.de>
In-Reply-To: <20051222001501.GI3917@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512212308.44496.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 December 2005 19:15, Adrian Bunk wrote:
> On Sat, Dec 17, 2005 at 11:42:54AM -0500, Dmitry Torokhov wrote:
> 
> > This patch fixes an OOPS in HID driver when connecting simulation
> > devices generating unknown simulation events.
> >...
> 
> This patch now went into Linus' tree.
> 
> It seems this patch should also go into 2.6.14.5?
> If you agree, please submit it to stable@kernel.org .
> 

Yes, you are right, I will send it there in a minute.

-- 
Dmitry
