Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267651AbUJRUEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267651AbUJRUEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 16:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267779AbUJRUDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 16:03:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57261 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267856AbUJRUB7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 16:01:59 -0400
Message-ID: <41742128.3030305@pobox.com>
Date: Mon, 18 Oct 2004 16:01:44 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org
Subject: Re: -final, a huge keyboard lag is back
References: <200410181139.16083.gene.heskett@verizon.net>
In-Reply-To: <200410181139.16083.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> Greetings;
> 
> for the last 3 or 4 minor revisions, and 3 different kde installs I 
> have had a situation wherein the keyboard repeat goes down to less 
> than 1 per second, making it very difficult to go back and fix the 
> typu's my ancient fingers inevitably make.  The effect came and went 
> at seemingly random times.

Does this happen on console, or just in X?

I am currently seeing:  fast keyboard repeat immediately after keypress, 
for one second.  After that, keyboard repeat slows immediately and 
dramatically, to a slower but consistent repeat rate.

This doesn't happen in console.

	Jeff



