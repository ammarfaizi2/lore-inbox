Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267301AbUIXEiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267301AbUIXEiN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 00:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267679AbUIXEiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 00:38:13 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:61432 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267301AbUIXEiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 00:38:12 -0400
Message-ID: <9e47339104092321383efdd7ee@mail.gmail.com>
Date: Fri, 24 Sep 2004 00:38:07 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: gene.heskett@verizon.net
Subject: Re: [patch 03/21] video/radeon_base: replace MS_TO_HZ() with msecs_to_jiffies()
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, akpm@digeo.com,
       nacc@us.ibm.com
In-Reply-To: <200409240012.47738.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <E1CAaFx-0000wQ-2B@sputnik>
	 <200409240012.47738.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That patch didn't fix your performance. It modifies the timer for the
panel backlight on laptops. Something else fixed your speed problem.

-- 
Jon Smirl
jonsmirl@gmail.com
