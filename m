Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751655AbWBMI7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbWBMI7t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 03:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbWBMI7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 03:59:49 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:44176 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751625AbWBMI7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 03:59:49 -0500
Date: Mon, 13 Feb 2006 09:59:28 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Phillip Susi <psusi@cfl.rr.com>
cc: Nicolas George <nicolas.george@ens.fr>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem for mobile hard drive
In-Reply-To: <43EFEE57.7070009@cfl.rr.com>
Message-ID: <Pine.LNX.4.61.0602130959050.2682@yvahk01.tjqt.qr>
References: <20060212150331.GA22442@clipper.ens.fr> <43EFD6E4.60601@cfl.rr.com>
 <20060213010701.GA8430@clipper.ens.fr> <43EFEE57.7070009@cfl.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> According to Wikipedia, and what I knew besides, FAT32 has a limit of 2 To
>> for the whole filesystem. But the limit I was talking of is the file size
>> limit: 4 Go perfile. Which is, nowadays, a bit short: an ISO image for a
>> DVD-R does not fit, for example.
>
> Ahh yes, the per file limit.  BTW, why are you saying "To" and "Go" when you
> apparently mean "TB" and "GB"?
>
French wording...



Jan Engelhardt
-- 
