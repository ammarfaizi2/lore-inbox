Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272792AbTG3HOa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 03:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272793AbTG3HOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 03:14:30 -0400
Received: from us01smtp1.synopsys.com ([198.182.44.79]:44214 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S272792AbTG3HO2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 03:14:28 -0400
Date: Wed, 30 Jul 2003 09:14:17 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Turning off automatic screen clanking
Message-ID: <20030730071417.GM13611@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307291750170.5874-100000@phoenix.infradead.org> <Pine.LNX.4.53.0307291338260.6166@chaos> <Pine.LNX.4.53.0307292015580.11053@montezuma.mastecende.com> <20030730012533.GA18663@mail.jlokier.co.uk> <Pine.LNX.4.53.0307292136050.11053@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307292136050.11053@montezuma.mastecende.com>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo, Wed, Jul 30, 2003 03:37:26 +0200:
> On Wed, 30 Jul 2003, Jamie Lokier wrote:
> 
> > One of Richard's points is that there is presently no way to fix the
> > box in userspace.  If the kernel crashes during boot, it will blank
> > the screen and there is no way to unblank it in that state.
> 
> Well something like this should work without complicating things during 
> panic.
> 

Does it unblank screen if panic happened while the screen was blanked?

