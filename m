Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbWCUWCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWCUWCR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 17:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWCUWCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 17:02:17 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:60138 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751798AbWCUWCP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 17:02:15 -0500
Date: Tue, 21 Mar 2006 23:01:58 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Phillip Lougher <phillip@lougher.demon.co.uk>, Pavel Machek <pavel@ucw.cz>,
       Phillip Lougher <phillip@lougher.org.uk>,
       "unlisted-recipients: no To-header on input <;, Jeff Garzik" 
	<jeff@garzik.org>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [ANN] Squashfs 3.0 released
In-Reply-To: <20060321200750.GH27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0603212301160.24534@yvahk01.tjqt.qr>
References: <20060317124310.GB28927@wohnheim.fh-wedel.de> <441ADD28.3090303@garzik.org>
 <0E3DADA8-1A1C-47C5-A3CF-F6A85FF5AFB8@lougher.org.uk> <441AF118.7000902@garzik.org>
 <20060319163249.GA3856@ucw.cz> <4420236F.80608@lougher.demon.co.uk>
 <20060321161452.GG27946@ftp.linux.org.uk> <44204F25.4090403@lougher.org.uk>
 <20060321191144.GB3929@elf.ucw.cz> <44205C1A.4040408@lougher.demon.co.uk>
 <20060321200750.GH27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>You mean, like IP?  Or NFS?  Or XFS?  Or any number of other big-endian
>data layouts?  Make it fixed to big-endian - no problem with that...
>
And most machines are little endian. So statistically, the world swapped 
more than it would have to.



Jan Engelhardt
-- 
