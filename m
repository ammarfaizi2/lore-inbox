Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268104AbUJLXpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268104AbUJLXpL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 19:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268092AbUJLXpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 19:45:11 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:56992
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S268108AbUJLXo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 19:44:57 -0400
Subject: Re: [Ext-rt-dev] Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Bill Huey <bhuey@lnxw.com>
Cc: dwalker@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, amakarov@ru.mvista.com,
       ext-rt-dev@mvista.com, LKML <linux-kernel@vger.kernel.org>,
       Doug Niehaus <niehaus@ittc.ku.edu>
In-Reply-To: <20041012233308.GA31150@nietzsche.lynx.com>
References: <20041010142000.667ec673.akpm@osdl.org>
	 <20041010215906.GA19497@elte.hu>
	 <1097517191.28173.1.camel@dhcp153.mvista.com>
	 <20041011204959.GB16366@elte.hu>
	 <1097607049.9548.108.camel@dhcp153.mvista.com>
	 <1097610393.19549.69.camel@thomas>
	 <20041012211201.GA28590@nietzsche.lynx.com>
	 <1097618415.19549.190.camel@thomas>
	 <20041012223642.GB30966@nietzsche.lynx.com>
	 <1097622634.19549.235.camel@thomas>
	 <20041012233308.GA31150@nietzsche.lynx.com>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1097624226.19549.252.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 13 Oct 2004 01:37:06 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-13 at 01:33, Bill Huey wrote:
> Yeah, I thought of it initially as a great idea, but ultimately this
> is going to impose on the overall Linux development methodology if
> these patches go into the mainstream.
> 
> I know what you're saying, but I ask you to be patient. All of this
> stuff is going to get clean up when I get some critical parts in place.
> And, yes, I do agree that this is unspeakably horrid. The static
> type determination thing probably will have to be removed at some point,
> but it's useful for rapid changing in the kernel at this time so that
> Ingo can make changes to keep up with MontaVista.
> 
> All I can ask is for folks to be patient as all groups get synced up
> to each other and then we'll be able to talk about it more meaningfully.
> A bunch of things will fall into place once we all parties are mentally
> synced up.

Hey, what are you talking about ?

Everybody should shut up, until some people have decided that others can
participate in the development ?

I proposed this to stop this stupid race for the better solution, which
is ugly and horrid, as you accept yourself.

There is no rush to push those enhancements within no time and there is
no Nobel prize to win.

Both groups have published their incomplete solutions and now we should
stop and contemplate how to merge this effort in a less nerve racking
way so we can improve and investigate this further on a common base.

tglx




