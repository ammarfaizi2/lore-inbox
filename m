Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313686AbSDPRLq>; Tue, 16 Apr 2002 13:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313696AbSDPRLp>; Tue, 16 Apr 2002 13:11:45 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:57818 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S313686AbSDPRLn>; Tue, 16 Apr 2002 13:11:43 -0400
From: David Lang <david.lang@digitalinsight.com>
To: "David S. Miller" <davem@redhat.com>
Cc: vojtech@suse.cz, dalecki@evision-ventures.com, rgooch@ras.ucalgary.ca,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 16 Apr 2002 10:09:38 -0700 (PDT)
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <20020416.100055.59660513.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0204161009040.3558-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I could be wrong, it's a 2.1.x kernel that they started with. I thought
that was around the time the fix went in.

David Lang

On Tue, 16 Apr 2002, David S. Miller wrote:

> Date: Tue, 16 Apr 2002 10:00:55 -0700 (PDT)
> From: David S. Miller <davem@redhat.com>
> To: david.lang@digitalinsight.com
> Cc: vojtech@suse.cz, dalecki@evision-ventures.com, rgooch@ras.ucalgary.ca,
>      torvalds@transmeta.com, linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] 2.5.8 IDE 36
>
>    From: David Lang <david.lang@digitalinsight.com>
>    Date: Tue, 16 Apr 2002 10:04:02 -0700 (PDT)
>
>    On Tue, 16 Apr 2002, Vojtech Pavlik wrote:
>
>    > Because for Linux filesystems it was decided some time ago (after people
>    > HAD huge byteswap problems) that ext2 is always LE, etc, etc. So
>    > filesystems are supposed to be the same on every system.
>
>    In the case of Tivo they are useing a kernel from the time before the fix
>    went in so even their ext2 partitions are incorrect (not to mention their
>    other partitions that aren't ext2)
>
> That's absurd.  I made the fix 6 years ago, I doubt they are using a
> kernel older than that.
>
