Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbTDQRGh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 13:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTDQRGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 13:06:37 -0400
Received: from riptidesoftware.com ([66.147.50.178]:36029 "EHLO
	ns1.riptidesoftware.com") by vger.kernel.org with ESMTP
	id S261783AbTDQRGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 13:06:36 -0400
Message-ID: <3E9EE1B3.7080801@aet-usa.com>
Date: Thu, 17 Apr 2003 13:17:39 -0400
From: Christopher Curtis <ccurtis@aet-usa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, root@chaos.analogic.com,
       joe briggs <jbriggs@briggsmedia.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Help with virus/hackers
References: <200304171545.h3HFjPoH000129@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200304171545.h3HFjPoH000129@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:

> I've often wondered whether it would be worth connecting a very large
> serial EEPROM to a serial port interface, and have it effectively
> appear as a solid state printer, (to that you could cheaply log to an
> unmodifyable device).  Has anybody ever tried this?

I suspect there are better solutions; namely another host running 
something like passlogd with the xmit wires cut and the hosts sending 
udp broadcast messages (or plug it into the monitor port of the switch). 
  Also, since the poster was running Woody, apt-cron'ing security might 
also lend itself to usefulness, along with apt-listchanges and maybe a 
little expect script.

rgds,
Chris

