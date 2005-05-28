Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVE1XZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVE1XZp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 19:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVE1XZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 19:25:26 -0400
Received: from box3.punkt.pl ([217.8.180.76]:57361 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S261214AbVE1XYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 19:24:13 -0400
Message-ID: <4298FD42.10608@punkt.pl>
Date: Sun, 29 May 2005 01:22:42 +0200
From: |TEcHNO| <techno@punkt.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050414 MultiZilla/1.6.4.0b
X-Accept-Language: en-gb, en-us, en-ca, en-au, ja, pl
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [SCSI] Driver broken in 2.6.x?
References: <424EB65A.8010600@punkt.pl> <20050525214047.731f56ef.akpm@osdl.org>
In-Reply-To: <20050525214047.731f56ef.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Is this crash still repeatable in 2.6.12-rc5?
> 
> If so, can you please verify that it still occurs if the nvidia driver was
> never loaded?

No, it works now as if it was 2.4.x series.
Now it just randomly hangs the system, ie. somewhere at the end of 
scanning or suchm no nothing in logs or similar. Simply hangs. My guess 
is that It shoudln't, no matter what, I always thought Linux was stable 
but the current problems (CDburning problems around 2.6.9, scanner/SCSI 
hanging the system) seem to  contradict this. That's bad.

-- 
pozdrawiam     |"Help me master, I felt the burning twilight behind
techno@punkt.pl|those gates of stell..." --Perihelion, Prophecy Sequence
