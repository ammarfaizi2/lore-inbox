Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423698AbWKFKNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423698AbWKFKNx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 05:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423724AbWKFKNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 05:13:53 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:23954 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1423698AbWKFKNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 05:13:52 -0500
Date: Mon, 6 Nov 2006 13:13:29 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Pavel Machek <pavel@ucw.cz>
Cc: Jonathan Lemon <jlemon@flugsvamp.com>, linux-kernel@vger.kernel.org
Subject: Re: [take22 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061106101329.GA16817@2ka.mipt.ru>
References: <20061103163012.GA84707@cave.trolltruffles.com> <20061105204741.GA1847@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061105204741.GA1847@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 06 Nov 2006 13:13:30 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2006 at 09:47:41PM +0100, Pavel Machek (pavel@ucw.cz) wrote:
> It has been show in this thread that kevent is too different to kqueue
> as is... but what are the advantages of kevent? Perhaps we should use
> kqueue on Linux, too (even if it means one more rewrite for you...?)

Should we use *BSD VMM system when we have superiour Linux one?

P.S. Do not drop Cc: list.

-- 
	Evgeniy Polyakov
