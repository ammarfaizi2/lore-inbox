Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271698AbRIPPTk>; Sun, 16 Sep 2001 11:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271129AbRIPPTb>; Sun, 16 Sep 2001 11:19:31 -0400
Received: from m3d.uib.es ([130.206.132.6]:148 "EHLO m3d.uib.es")
	by vger.kernel.org with ESMTP id <S271698AbRIPPTV>;
	Sun, 16 Sep 2001 11:19:21 -0400
Date: Sun, 16 Sep 2001 17:19:43 +0200 (MET)
From: Ricardo Galli <gallir@m3d.uib.es>
To: <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
Message-ID: <Pine.LNX.4.33.0109161711430.30482-100000@m3d.uib.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So whether Linux uses swap or not is a 100% meaningless indicator of
> "goodness". The only thing that matters is how well the job gets done,
> ie was it reasonably responsive, and did the big untars finish quickly..

I am running 2.4.9 on a PII with 448MB RAM. After listening a couple of
hours MP3 from the /dev/cdrom and KDE started, more than 70MB went to
swap, about 300 MB in cache and KDE takes about 15-20 seconds just for
logging out and showing the greeting console.

Obviously, all apps went to disk to leave space for caching mp3 files that
are read only once. Altough logging out is not a very often process...

Regards,


--ricardo


