Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263923AbTLOUXH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 15:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263904AbTLOUXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 15:23:05 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:31174 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264137AbTLOUWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 15:22:38 -0500
Date: Mon, 15 Dec 2003 15:21:20 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler
In-Reply-To: <3FDAB517.4000309@cyberone.com.au>
Message-ID: <Pine.LNX.4.58.0312151517290.2102@montezuma.fsmlabs.com>
References: <20031213022038.300B22C2C1@lists.samba.org> <3FDAB517.4000309@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nick,
	This is somewhat unrelated to the current thread topic direction,
but i noticed that your HT scheduler really behaves oddly when the box is
used interactively. The one application which really seemed to be
misbehaving was 'gaim', whenever someone typed a message X11 would pause
for a second or so until the text displayed causing the mouse to jump
around erratically. I can try help with this but unfortunately i can't do
too much rebooting this week due to work (main workstation), but perhaps
we can discuss it over a weekend. The system is 4x logical 2.0GHz.

Thanks
