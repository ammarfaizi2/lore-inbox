Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbULYAvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbULYAvf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 19:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbULYAvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 19:51:35 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52928 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261469AbULYAuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 19:50:22 -0500
Subject: Re: 2.6.10 xfs segfault on boot startup?
From: Lee Revell <rlrevell@joe-job.com>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200412241942.36264.gene.heskett@verizon.net>
References: <200412241942.36264.gene.heskett@verizon.net>
Content-Type: text/plain
Date: Fri, 24 Dec 2004 19:50:21 -0500
Message-Id: <1103935821.9525.1.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-24 at 19:42 -0500, Gene Heskett wrote:
> Greetings all;
> 
> I just rebooted to a "still got that new car smell" fresh 2.6.10, and 
> this went by on the boot screen while it was starting the various 
> services in init.d:
> 
> Starting xfs: /etc/rc3.d/S90xfs: line 137:  2377 Segmentation fault      
> ttmkfdir -d . -o fonts.scale
> /etc/rc3.d/S90xfs: line 137:  2404 Segmentation fault      ttmkfdir 
> -d . -o fonts.scale

If that was a kernel problem you would probably have an Oops.

Lee

