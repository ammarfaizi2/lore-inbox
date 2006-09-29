Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWI2Sk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWI2Sk0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 14:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWI2Sk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 14:40:26 -0400
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:61968 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751292AbWI2SkZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 14:40:25 -0400
Date: Fri, 29 Sep 2006 20:40:25 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: Re: [GIT PATCH] HWMon patches for 2.6.18
Message-Id: <20060929204025.9bbad04b.khali@linux-fr.org>
In-Reply-To: <20060928224248.GA23843@kroah.com>
References: <20060928224248.GA23843@kroah.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here are some hwmon patches for 2.6.18.  They include a new driver, and
> a bunch of warning fixes that cleaned up the code a lot.

Two new drivers, actually (vt1211 and k8temp.)

> Half of these have been in the -mm tree for a while, the other half were
> in Jean's tree for too long before I added them to mine (the delay was
> my fault.)

I checked against my patch stack and everything's in order. Thanks Greg!

-- 
Jean Delvare
