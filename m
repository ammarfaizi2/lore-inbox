Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932750AbVITHOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750AbVITHOg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 03:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932751AbVITHOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 03:14:36 -0400
Received: from rwcrmhc14.comcast.net ([204.127.198.54]:53234 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932750AbVITHOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 03:14:35 -0400
Date: Tue, 20 Sep 2005 00:15:14 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Luke Yang <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ADI Blackfin porting for kernel-2.6.13
Message-ID: <20050920071514.GA10909@plexity.net>
Reply-To: dsaxena@plexity.net
References: <489ecd0c05091923336b48555@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <489ecd0c05091923336b48555@mail.gmail.com>
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 20 2005, at 14:33, Luke Yang was caught saying:
> Hi,
> 
>    I am Luke Yang, an engineer from Analog Devices Inc. We ported
> uclinux to our Blackfin cpu. Now we updated our architecture code for
> kernel-2.6.13. I will send out a patch to this list.
> 
>    I know kernel-2.6.14 is coming. Will the linux kernel accept our
> patch for 2.6.13?

Nope. 2.6.13 is now closed to new features as is 2.6.14 (unless it is 
a really sper special case that Linus feels is important enough to slip 
in).  At this point the best thing to do is to post your patches for review,
make the changes that are asked, and be ready to post a patch vs 2.6.14
within the first week after it is released so that it might be be picked
up for 2.6.15.

~Deepak

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
