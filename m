Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270530AbTGNFd4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 01:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270531AbTGNFd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 01:33:56 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:31383 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S270530AbTGNFdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 01:33:54 -0400
Message-ID: <3F124734.1020300@genebrew.com>
Date: Mon, 14 Jul 2003 02:01:24 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lich@tuxfamily.org
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.75 doesn't boot at all on x86
References: <1058160485.3f123f65da7fa@www.france-techno.com>
In-Reply-To: <1058160485.3f123f65da7fa@www.france-techno.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> modprobe fails on /etc/modules.devfs and /etc/modules.conf at each
> probeall line.
> therefore, I dont have all modules up, particularly no mouse, no sound,
> no pcmcia, no acpi, no ide-scsi cdrw/dvd ....

Download, compile and install the latest module-init-tools from:

http://www.kernel.org/pub/linux/kernel/people/rusty/modules/

There are other things you may need for 2.5 kernels after migrating from 
a 2.4 setup. Dave Jones has documented some of these at:

http://www.codemonkey.org.uk/post-halloween-2.5.txt

-Rahul

