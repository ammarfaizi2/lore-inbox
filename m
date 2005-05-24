Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVEXXtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVEXXtG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 19:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbVEXXtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 19:49:04 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:20004 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262174AbVEXXsm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 19:48:42 -0400
Message-ID: <4293BD80.1050503@danbbs.dk>
Date: Wed, 25 May 2005 01:49:20 +0200
From: Mogens Valentin <monz@danbbs.dk>
Reply-To: monz@danbbs.dk
Organization: Mr Dev
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dougg@torque.net
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] sdparm 0.92
References: <428DC633.5050403@torque.net>
In-Reply-To: <428DC633.5050403@torque.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert wrote:
> sdparm is a command line utility designed to get and set
> SCSI disk parameters (cf hdparm for ATA disks). More generally
> it gets and sets mode page information on SCSI devices or devices
> that use a SCSI command set (e.g. CD/DVD drives (any transport)
> and SCSI tape drives). It also can list VPD pages including
> the device identification page.
> 
> For more information and downloads (tarball, rpm and deb
> packages) see:
> http://www.torque.net/sg/sdparm.html

Nice! Just got it and tried on an external usb disk.
One feature I could use, probably others as well:
Could you add the ability to spin down/up a scsi disk?
I'd really like this for exteral (usb) disks.

Doesn't seem it can; if I missed it, I'm sorry..

-- 
Kind regards,
Mogens Valentin

