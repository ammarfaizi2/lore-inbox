Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965129AbWCUWMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbWCUWMG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965130AbWCUWMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:12:05 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:51123 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965129AbWCUWMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:12:02 -0500
Message-ID: <44207A25.6040302@garzik.org>
Date: Tue, 21 Mar 2006 17:11:49 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Al Viro <viro@ftp.linux.org.uk>,
       Phillip Lougher <phillip@lougher.demon.co.uk>,
       Pavel Machek <pavel@ucw.cz>, Phillip Lougher <phillip@lougher.org.uk>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [ANN] Squashfs 3.0 released
References: <20060317124310.GB28927@wohnheim.fh-wedel.de> <441ADD28.3090303@garzik.org> <0E3DADA8-1A1C-47C5-A3CF-F6A85FF5AFB8@lougher.org.uk> <441AF118.7000902@garzik.org> <20060319163249.GA3856@ucw.cz> <4420236F.80608@lougher.demon.co.uk> <20060321161452.GG27946@ftp.linux.org.uk> <44204F25.4090403@lougher.org.uk> <20060321191144.GB3929@elf.ucw.cz> <44205C1A.4040408@lougher.demon.co.uk> <20060321200750.GH27946@ftp.linux.org.uk> <Pine.LNX.4.61.0603212301160.24534@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0603212301160.24534@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.5 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>You mean, like IP?  Or NFS?  Or XFS?  Or any number of other big-endian
>>data layouts?  Make it fixed to big-endian - no problem with that...
>>
> 
> And most machines are little endian. So statistically, the world swapped 
> more than it would have to.

No, rather, the more powerful machines do the swapping.

	Jeff


