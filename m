Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWAJVak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWAJVak (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 16:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWAJVak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 16:30:40 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:1456 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932347AbWAJVaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 16:30:39 -0500
Date: Tue, 10 Jan 2006 22:30:32 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andi Kleen <ak@suse.de>
cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Console debugging wishlist was: Re: oops pauser.
In-Reply-To: <200601102218.30998.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0601102229110.15968@yvahk01.tjqt.qr>
References: <20060105045212.GA15789@redhat.com> <200601102145.53967.ak@suse.de>
 <Pine.LNX.4.61.0601102200410.1000@yvahk01.tjqt.qr> <200601102218.30998.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>But it wasn't actually my point. If you get 
>an problem during bootup - not necessarily an oops, but could
>be also a no root panic or your SCSI controller not working or 
>something else - and you can reproduce it it's a PITA to examine
>the kernel output before because there is no way to get
>enough scrollback.  For the oops itself it's not needed - it typically
>fits on the screen. But if it happens every boot it would be nice
>if you could just boot with "more" and then page through
>the kernel output and check what's going on.

Ah yes, I had not considered boot oopses/panics. My bad.



Jan Engelhardt
-- 
