Return-Path: <linux-kernel-owner+w=401wt.eu-S936679AbWLIJiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936679AbWLIJiN (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 04:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936680AbWLIJiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 04:38:13 -0500
Received: from mx0.towertech.it ([213.215.222.73]:50194 "HELO mx0.towertech.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S936679AbWLIJiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 04:38:12 -0500
Date: Sat, 9 Dec 2006 10:38:02 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: rtc-linux@googlegroups.com
Cc: david-b@pacbell.net, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Riku Voipio <riku.voipio@movial.fi>
Subject: Re: [rtc-linux] [patch 2.6.19-git] rts-rs5c372 updates:  more
 chips, alarm, 12hr mode, etc
Message-ID: <20061209103802.05c7ba76@inspiron>
In-Reply-To: <200612081859.42995.david-b@pacbell.net>
References: <200612081859.42995.david-b@pacbell.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006 18:59:41 -0800
David Brownell <david-b@pacbell.net> wrote:

> 
> Note that this reverts part of a previous patch, which seems to have
> included key parts of the initial version of this one.  I suspect the
> issue wasn't that "mode 1" didn't work on that board; the original
> code to fetch the trim was broken.  If "mode 1" really won't work,
> that's almost certainly a bug in that board's I2C driver.

 Riku, can you please test it on your platform to see
 if mode 1 works nicely?

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

