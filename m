Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbTHZRsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 13:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbTHZRq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 13:46:56 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:12047
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261413AbTHZRqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 13:46:49 -0400
Date: Tue, 26 Aug 2003 10:46:46 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: Re: cache limit
Message-ID: <20030826174646.GF16831@matchmail.com>
Mail-Followup-To: Ihar 'Philips' Filipau <filia@softhome.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Takao Indoh <indou.takao@soft.fujitsu.com>
References: <n7lV.2HA.19@gated-at.bofh.it> <ofAJ.4dx.9@gated-at.bofh.it> <ogZM.5KJ.1@gated-at.bofh.it> <oyDw.5FP.33@gated-at.bofh.it> <3F4B3352.4000703@softhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4B3352.4000703@softhome.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 12:15:46PM +0200, Ihar 'Philips' Filipau wrote:
>   If I have 1GB of memory and my applications for use only 16MB - it 
> doesn't mean I want to fill 1GB-16MB with garbage like file my momy had 
> viewed two weeks ago.
> 
>   That's it: OS should scale for *application* *needs*.
> 
>   Can you compare in your mind overhead of managing 1GB of cache with 
> managing e.g. 16MB of cache?
> 

Ok, let's benchmark it.

Yes, I can see the logic in your argument, but at this point, numbers are
needed to see if or how much of a win this might be.
