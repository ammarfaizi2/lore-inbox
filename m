Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWAVTFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWAVTFe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 14:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWAVTFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 14:05:34 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39952 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751034AbWAVTFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 14:05:33 -0500
Date: Sun, 22 Jan 2006 20:05:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: soft update vs journaling?
Message-ID: <20060122190533.GH10003@stusta.de>
References: <43D3295E.8040702@comcast.net> <Pine.LNX.4.61.0601220945160.5126@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601220945160.5126@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2006 at 09:51:10AM +0100, Jan Engelhardt wrote:
>...
>  - I would not use a journalling filesystem at all on media that degrades
>    faster as harddisks (flash drives, CD-RWs/DVD-RWs/RAMs).
>    There are specially-crafted filesystems for that, mostly jffs and udf.
>...

[ ] you know what the "j" in "jffs" stands for

> Jan Engelhardt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

