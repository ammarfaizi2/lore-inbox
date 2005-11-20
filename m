Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbVKTSRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbVKTSRt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 13:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbVKTSRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 13:17:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11423 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750865AbVKTSRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 13:17:48 -0500
Date: Sun, 20 Nov 2005 10:17:38 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Miloslav Trmac <mitr@volny.cz>
Subject: Re: [git pull 00/14] Input updates for 2.6.15
In-Reply-To: <200511201242.08506.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.64.0511201016220.13959@g5.osdl.org>
References: <20051120063611.269343000.dtor_core@ameritech.net>
 <200511201204.08012.dtor_core@ameritech.net> <Pine.LNX.4.64.0511200919080.13959@g5.osdl.org>
 <200511201242.08506.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 Nov 2005, Dmitry Torokhov wrote:
> 
> That cinergyT2 fix (from Linux-2.6.15-rc2 thread) - do you already have it
> or would you prefer a pull prepared later tonight?

The only one I have is the one I got through davem a couple of days ago: 

  cinergyT2: cinergyt2_register_rc() should return 0 on success

is that the one you're talking about?

		Linus
