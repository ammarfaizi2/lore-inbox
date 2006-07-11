Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWGKSGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWGKSGj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWGKSGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:06:38 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:19022 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751165AbWGKSGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:06:37 -0400
Message-ID: <44B3E8A8.8090405@tls.msk.ru>
Date: Tue, 11 Jul 2006 22:06:32 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Olaf Hering <olh@suse.de>, Jeff Garzik <jeff@garzik.org>,
       Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
       klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060711044834.GA11694@suse.de> <44B37D9D.8000505@tls.msk.ru> <20060711112746.GA14059@suse.de> <44B3D0A0.7030409@zytor.com> <20060711164040.GA16327@suse.de> <44B3DA77.50103@garzik.org> <20060711171624.GA16554@suse.de> <44B3E7D5.8070100@zytor.com>
In-Reply-To: <44B3E7D5.8070100@zytor.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Olaf Hering wrote:
[]
> [...] in general old
> klibcs should continue to work (but may not compile against a newer
> kernel), but a newer klibc may not work on an older kernel.

Heh.  Olaf says about "basic backwards compatibilty", referring to
the klingon dictionary...

(please don't treat this as an offense - just.. funny)

/mjt
