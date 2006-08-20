Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751717AbWHTJDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbWHTJDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 05:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbWHTJDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 05:03:21 -0400
Received: from mail.gmx.de ([213.165.64.20]:62369 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751715AbWHTJDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 05:03:20 -0400
X-Authenticated: #14349625
Subject: Re: [Bugme-new] [Bug 7027] New: CD Ripping speeds slow with 2.6.17
From: Mike Galbraith <efault@gmx.de>
To: brnewber@gmail.com
Cc: Ingo Molnar <mingo@elte.hu>, Martin Bligh <mbligh@mbligh.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1156068220.6034.1.camel@Homer.simpson.net>
References: <200608191800.k7JI0ML0015395@fire-2.osdl.org>
	 <20060819111437.a88f71cd.akpm@osdl.org>
	 <1156062478.6690.65.camel@Homer.simpson.net>
	 <1156068220.6034.1.camel@Homer.simpson.net>
Content-Type: text/plain
Date: Sun, 20 Aug 2006 11:11:40 +0000
Message-Id: <1156072300.5052.7.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-20 at 10:03 +0000, Mike Galbraith wrote:
> On Sun, 2006-08-20 at 08:27 +0000, Mike Galbraith wrote:
> 
> > I'm skeptical.  Is the source for this application available?  I'd like
> > to see this problem.
> 
> (never mind.  saw your other post, found source)

Hm.  I can't get better than 1.4x rip speed out of it with a stock SuSE
10.1 kernel (2.6.16).  It's also using truckloads of cpu, whereas the CD
rippers that came with this distro use a percent or two.

	-Mike

