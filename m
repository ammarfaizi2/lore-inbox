Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030468AbWGZJMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbWGZJMV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 05:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbWGZJMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 05:12:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53984 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030468AbWGZJMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 05:12:20 -0400
Date: Wed, 26 Jul 2006 05:11:50 -0400
From: Alan Cox <alan@redhat.com>
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: Edgar Toernig <froese@gmx.de>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>, akpm@osdl.org,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org, alan@redhat.com, torvalds@osdl.org
Subject: Re: [v4l-dvb-maintainer] Re: [PATCH 00/23] V4L/DVB fixes
Message-ID: <20060726091150.GA27682@devserv.devel.redhat.com>
References: <20060725180311.PS54604900000@infradead.org> <20060726004127.6eab5a9f.froese@gmx.de> <Pine.LNX.4.58.0607251741350.8253@shell3.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0607251741350.8253@shell3.speakeasy.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 06:00:25PM -0700, Trent Piepho wrote:
> On Wed, 26 Jul 2006, Edgar Toernig wrote:
> > I'm still missing the VBI_OFFSET fix.  See:
> >
> >   http://marc.theaimsgroup.com/?m=114710558215044
> >
> > Could you consider that patch for the next update and
> > IMHO also for 2.6.16.x and 2.6.17.x?
> 
> I've put a patch that fixes this in my tree.  Mauro, please pull from
> http://linuxtv.org/hg/~tap/v4l-dvb for:

Acked-by: Alan Cox <alan@redhat.com>
