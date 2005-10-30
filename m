Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbVJ3T6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbVJ3T6P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 14:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVJ3T6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 14:58:15 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.117]:53962 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932255AbVJ3T6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 14:58:14 -0500
Date: Sun, 30 Oct 2005 11:58:13 -0800
From: Deepak Saxena <dsaxena@plexity.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, tony@atomide.com,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 0/5] HW RNG cleanup & new drivers
Message-ID: <20051030195813.GA4794@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20051029191229.562454000@omelas> <4363F31F.2040303@pobox.com> <Pine.LNX.4.64.0510291524050.3348@g5.osdl.org> <4363F8A6.2050501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4363F8A6.2050501@pobox.com>
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 29 2005, at 18:33, Jeff Garzik was caught saying:
> Linus Torvalds wrote:
> >On Sat, 29 Oct 2005, Jeff Garzik wrote:
> >>I would prefer to let this live in -mm at least for a little while.
> >>Confirmation from AMD, Intel and VIA owners would be really nice, too. 
> >>AMD and
> >>Intel might be a little bit hard to find.  I think Peter Anvin had an 
> >>Intel
> >>ICH w/ RNG at one time...
> >
> >I'm just wondering why via/amd/intel end up being one driver. It would 
> >seem to be more sensible to have separate drivers for them, since they 
> >have no real overlap..
> 
> No real reason other than historical.  Split up would be my preference.

OK, will split and send to Andrew for -mm tree.

~Deepak

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

When law and duty are one, united by religion, you never become fully
conscious, fully aware of yourself. You are always a little less than
an individual. - Frank Herbert
