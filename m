Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750880AbWFDSLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWFDSLw (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 14:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbWFDSLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 14:11:51 -0400
Received: from gw.goop.org ([64.81.55.164]:20915 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750806AbWFDSLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 14:11:51 -0400
Message-ID: <44832262.3050701@goop.org>
Date: Sun, 04 Jun 2006 11:11:46 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, axboe@suse.de, linux-ide@vger.kernel.org
Subject: Re: [2.6.17-rc5-mm2+ahci resume] NULL pointer dereference in cfq_dispatch_requests
References: <4482389F.6030403@goop.org> <20060603184134.ee6dcc3b.akpm@osdl.org>
In-Reply-To: <20060603184134.ee6dcc3b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> There have been a number of CFQ fixes post-2.6.17-rc5-mm2.  Fingers
> crossed, please test -mm3.  Hopefully I'll have that out 4-6 hours hence

mm3 seems to have fixed it.

    J
