Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262640AbVHDU3B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbVHDU3B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbVHDU1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:27:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14522 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262727AbVHDU1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:27:16 -0400
Date: Thu, 4 Aug 2005 22:27:01 +0200
From: Pavel Machek <pavel@suse.cz>
To: Frank Loeffler <knarf.loeffler@freenet.de>
Cc: mdew <some.nzguy@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [linux-usb-devel] Re: Fw: ati-remote strangeness from 2.6.12 onwards
Message-ID: <20050804202701.GB1285@elf.ucw.cz>
References: <20050730173253.693484a2.akpm@osdl.org> <1c1c8636050801220442d8351c@mail.gmail.com> <20050803055413.GB1399@elf.ucw.cz> <1c1c86360508030311486fc30a@mail.gmail.com> <42F0AD60.3070201@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F0AD60.3070201@freenet.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> - You might want to differentiate between this key and the ENTER key
>   of your keyboard, at least I do. If the kernel is sending the same
>   code for both keys, this is not possible in userspace.

No, I think that you can still diferentiate between them ... they come
from different keyboard after all. See /dev/input/event*.

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
