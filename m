Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750850AbWHVAO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWHVAO2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 20:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWHVAO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 20:14:28 -0400
Received: from calculon.skynet.ie ([193.1.99.88]:31889 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1750850AbWHVAO1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 20:14:27 -0400
Date: Tue, 22 Aug 2006 01:14:25 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: Christian Merkle <mail@christian-merkle.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       sylvain.meyer@worldonline.fr, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] intelfb: update doc and Kconfig (supported devices)
In-Reply-To: <44E64B05.3050205@christian-merkle.de>
Message-ID: <Pine.LNX.4.64.0608220114090.658@skynet.skynet.ie>
References: <44E64B05.3050205@christian-merkle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> According to drivers/video/intelfb/intelfb.h, the intelfb driver
> supportes the following devices:
> 830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM. So the description in
> drivers/video/Kconfig and the documentation in
> Documentation/fb/intelfb.txt is outdated.
>
> Signed-off-by: Christian Merkle <mail@christian-merkle.de>

Applied to intelfb tree...

Dave.
