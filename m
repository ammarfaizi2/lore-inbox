Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbUCJVEz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 16:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbUCJVEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 16:04:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:50610 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262839AbUCJVBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 16:01:44 -0500
X-Authenticated: #4512188
Message-ID: <404F823F.9030409@gmx.de>
Date: Wed, 10 Mar 2004 22:01:51 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: walt <wa1ter@myrealbox.com>
CC: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
References: <fa.dbn18ei.1k46o3i@ifi.uio.no> <fa.afjk56q.t0ulic@ifi.uio.no> <404F11D0.8010003@myrealbox.com>
In-Reply-To: <404F11D0.8010003@myrealbox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

walt wrote:
> Prakash K. Cheemplavam wrote:
> 
>> When I insert a zip the /dev for the partition doesn't get created (ie 
>> hdd4, fdisk shows it though).
> 
> 
> My Zips always show up as /dev/sda4 (scsi disks).

Do you have SCSI support compiled in? For me it doesn't (I have no SCSI 
support in, as well.) Are you using a USB ZIP? I have a ATAPI ZIP, so it 
makes no sense appearing as a SCSI device.

Prakash
