Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313774AbSDPRSm>; Tue, 16 Apr 2002 13:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313775AbSDPRSl>; Tue, 16 Apr 2002 13:18:41 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:18847 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S313774AbSDPRSj>; Tue, 16 Apr 2002 13:18:39 -0400
From: David Lang <david.lang@digitalinsight.com>
To: "David S. Miller" <davem@redhat.com>
Cc: vojtech@suse.cz, dalecki@evision-ventures.com, rgooch@ras.ucalgary.ca,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 16 Apr 2002 10:16:43 -0700 (PDT)
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <20020416.100610.115916272.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0204161015580.3558-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, in that case it must be a wierd wiring of the IDE or something.

I thought it was something more logical (silly me :-)

David Lang

On Tue, 16 Apr 2002, David S. Miller wrote:

> Date: Tue, 16 Apr 2002 10:06:10 -0700 (PDT)
> From: David S. Miller <davem@redhat.com>
> To: david.lang@digitalinsight.com
> Cc: vojtech@suse.cz, dalecki@evision-ventures.com, rgooch@ras.ucalgary.ca,
>      torvalds@transmeta.com, linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] 2.5.8 IDE 36
>
>    From: David Lang <david.lang@digitalinsight.com>
>    Date: Tue, 16 Apr 2002 10:09:38 -0700 (PDT)
>
>    I could be wrong, it's a 2.1.x kernel that they started with. I thought
>    that was around the time the fix went in.
>
> Again, I did the fix 6 years ago, thats pre-2.0.x days
>
> EXT2 has been little-endian only with proper byte-swapping support
> across all architectures, since that time.
>
