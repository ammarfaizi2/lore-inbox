Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265698AbUFSNWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265698AbUFSNWu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 09:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265706AbUFSNWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 09:22:49 -0400
Received: from ns1.skjellin.no ([80.239.42.66]:722 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S265698AbUFSNWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 09:22:47 -0400
Message-ID: <40D43E26.7060207@tomt.net>
Date: Sat, 19 Jun 2004 15:22:46 +0200
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ian Kumlien <pomac@vapor.com>
Subject: Re: [sundance] Known problems?
References: <1087650302.2971.44.camel@big>
In-Reply-To: <1087650302.2971.44.camel@big>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kumlien wrote:

> Hi,
> 
> I changed my networking card back to my dlink DFE-580tx (one of those 4
> port 100mbit cards that uses the alta chipset). And now the watchdog
> keep killing the connection.
> 
> The max bw that is being used is aprox 5.5 megabyte/s (to avoid
> confusion). Has there been any work done with this recently or during
> 2.5/6 development? Afair i had no problems with it in 2.4.x when my
> firewall used it.
> 
> CC, I'm not subscribed.

FYI;

Other than beeing a slow card with mmio-bugs, the only problems I have 
had with that card was when having a kernel patched with the now defunct 
and buggy IMQ. Problems were identical.

-- 
Cheers,
André Tomt
