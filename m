Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbTK3TJr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 14:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbTK3TJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 14:09:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54197 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263015AbTK3TJo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 14:09:44 -0500
Message-ID: <3FCA4068.7000600@pobox.com>
Date: Sun, 30 Nov 2003 14:09:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eduard Hasenleithner <ehasenle@spamcop.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Better performance with pdc20376 compared to SiI 3112
References: <3FC7DEB3.7030104@spamcop.net>
In-Reply-To: <3FC7DEB3.7030104@spamcop.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eduard Hasenleithner wrote:
> Hello.
> 
> Although I like the SiI 3112 due it's open specs I found that the
> somehow "closed" pdc20376 promise chip performs essentially better
> with the new GPL drivers on a non-tweaked 2.6.0-test11 kernel :(
> With SiI 3112 I get about 16MB/s, with pdc20376 54MB/s, which is
> most likely the maximum harddisk performance of my seagate drive.

Like Bart mentioned, both Promise and SiI are the same:  closed specs, 
GPL'd driver.


> So what is the status of the siimage driver? Can I expect it to
> improve in further kernel releases?

I certainly hope so :)  We're actively discussing the 3112 errata fix 
right now...

	Jeff



