Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbTIZDOU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 23:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbTIZDOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 23:14:20 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:39042 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S261438AbTIZDOT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 23:14:19 -0400
Date: Thu, 25 Sep 2003 23:14:14 -0400
From: Yaroslav Halchenko <yoh@onerussian.com>
To: Milton Miller <miltonm@bga.com>, Greg KH <greg@kroah.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: USB problem. 'irq 9: nobody cared!'
Message-ID: <20030926031414.GA26790@washoe.rutgers.edu>
Mail-Followup-To: Milton Miller <miltonm@bga.com>, Greg KH <greg@kroah.com>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200309242257.h8OMvR5d090443@sullivan.realtime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309242257.h8OMvR5d090443@sullivan.realtime.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried again with recent bk12 kernel and this patch worked... 

May be I was too tired and actually didn't patch the first time I
tried, and then reported to you that it didn't help - I'm sorry. Will
check later if it is the case.

Thanx for your help

Sincerely 
Yarik

On Wed, Sep 24, 2003 at 05:57:27PM -0500, Milton Miller wrote:
> 
> Yaroslav Halchenko wrote:
> > Greg KH wrote:
> > > Did you try David Brownell's patch for this issue?
> > Can you please point which one exactly? I've tried to locate patch you
> > meant but it is too much of USB staff is happening now seems to me.
> 
> 
> I'm guessing this one: Re: irq 11: nobody cared! is back
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106399942523614&w=2
> 
> 
> milton
                                  .-.
=------------------------------   /v\  ----------------------------=
Keep in touch                    // \\     (yoh@|www.)onerussian.com
Yaroslav Halchenko              /(   )\               ICQ#: 60653192
                   Linux User    ^^-^^    [175555]
