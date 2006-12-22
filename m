Return-Path: <linux-kernel-owner+w=401wt.eu-S1751157AbWLVRFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWLVRFG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 12:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWLVRFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 12:05:05 -0500
Received: from torres.zugschlus.de ([85.10.211.154]:3010 "EHLO
	torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbWLVRFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 12:05:04 -0500
Date: Fri, 22 Dec 2006 18:05:03 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 file content corruption on ext3
Message-ID: <20061222170503.GE21794@torres.zugschlus.de>
References: <20061207155740.GC1434@torres.l21.ma.zugschlus.de> <4578465D.7030104@cfl.rr.com> <20061209092639.GA15443@torres.l21.ma.zugschlus.de> <20061216184310.GA891@unjust.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061216184310.GA891@unjust.cyrius.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2006 at 06:43:10PM +0000, Martin Michlmayr wrote:
> * Marc Haber <mh+linux-kernel@zugschlus.de> [2006-12-09 10:26]:
> > Unfortunately, I am lacking the knowledge needed to do this in an
> > informed way. I am neither familiar enough with git nor do I possess
> > the necessary C powers.
> 
> I wonder if what you're seein is related to
> http://lkml.org/lkml/2006/12/16/73
> 
> You said that you don't see any corruption with 2.6.18.  Can you try
> to apply the patch from
> http://www2.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=d08b3851da41d0ee60851f2c75b118e1f7a5fc89
> to 2.6.18 to see if the corruption shows up?

Since I am no longer seeing the issue after easing the memory load, I
doubt that this would make sense.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Mannheim, Germany  |  lose things."    Winona Ryder | Fon: *49 621 72739834
Nordisch by Nature |  How to make an American Quilt | Fax: *49 621 72739835
