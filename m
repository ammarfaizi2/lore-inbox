Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVLCSSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVLCSSu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 13:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbVLCSSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 13:18:50 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:46913 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S932118AbVLCSSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 13:18:50 -0500
Date: Sat, 03 Dec 2005 09:31:03 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
In-reply-to: <20051203135608.GJ31395@stusta.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <1133620264.2171.14.camel@localhost.localdomain>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.2
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20051203135608.GJ31395@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-03 at 14:56 +0100, Adrian Bunk wrote:
> The current kernel development model is pretty good for people who 
> always want to use or offer their costumers the maximum amount of the 
> latest bugs^Wfeatures without having to resort on additional patches for 
> them.
> 
> Problems of the current development model from a user's point of view 
> are:
> - many regressions in every new release
> - kernel updates often require updates for the kernel-related userspace 
>   (e.g. for udev or the pcmcia tools switch)
> 
> One problem following from this is that people continue to use older 
> kernels with known security holes because the amount of work for kernel 
> upgrades is too high.

What you're suggesting sounds just like going back to the old style of
development where 2.<even>.x is stable, and 2.<odd>.x is development.
You might as well just suggest that after 2.6.16, we fork to 2.7.0, and
2.6.17+ will be stable increments like we always used to do.

You're just munging the version scheme :)

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

