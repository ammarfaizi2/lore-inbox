Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313671AbSDPRKX>; Tue, 16 Apr 2002 13:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313682AbSDPRKX>; Tue, 16 Apr 2002 13:10:23 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16533 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313671AbSDPRKV>;
	Tue, 16 Apr 2002 13:10:21 -0400
Date: Tue, 16 Apr 2002 10:00:55 -0700 (PDT)
Message-Id: <20020416.100055.59660513.davem@redhat.com>
To: david.lang@digitalinsight.com
Cc: vojtech@suse.cz, dalecki@evision-ventures.com, rgooch@ras.ucalgary.ca,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.8 IDE 36
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0204161002420.3558-100000@dlang.diginsite.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Lang <david.lang@digitalinsight.com>
   Date: Tue, 16 Apr 2002 10:04:02 -0700 (PDT)

   On Tue, 16 Apr 2002, Vojtech Pavlik wrote:
   
   > Because for Linux filesystems it was decided some time ago (after people
   > HAD huge byteswap problems) that ext2 is always LE, etc, etc. So
   > filesystems are supposed to be the same on every system.
   
   In the case of Tivo they are useing a kernel from the time before the fix
   went in so even their ext2 partitions are incorrect (not to mention their
   other partitions that aren't ext2)
   
That's absurd.  I made the fix 6 years ago, I doubt they are using a
kernel older than that.
