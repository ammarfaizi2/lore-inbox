Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313770AbSDPRP1>; Tue, 16 Apr 2002 13:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313772AbSDPRP0>; Tue, 16 Apr 2002 13:15:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21909 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313770AbSDPRPZ>;
	Tue, 16 Apr 2002 13:15:25 -0400
Date: Tue, 16 Apr 2002 10:06:10 -0700 (PDT)
Message-Id: <20020416.100610.115916272.davem@redhat.com>
To: david.lang@digitalinsight.com
Cc: vojtech@suse.cz, dalecki@evision-ventures.com, rgooch@ras.ucalgary.ca,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.8 IDE 36
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0204161009040.3558-100000@dlang.diginsite.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Lang <david.lang@digitalinsight.com>
   Date: Tue, 16 Apr 2002 10:09:38 -0700 (PDT)

   I could be wrong, it's a 2.1.x kernel that they started with. I thought
   that was around the time the fix went in.
   
Again, I did the fix 6 years ago, thats pre-2.0.x days

EXT2 has been little-endian only with proper byte-swapping support
across all architectures, since that time.
