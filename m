Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290809AbSBLHPK>; Tue, 12 Feb 2002 02:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290810AbSBLHPB>; Tue, 12 Feb 2002 02:15:01 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:3338 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S290809AbSBLHOt>;
	Tue, 12 Feb 2002 02:14:49 -0500
Date: Tue, 12 Feb 2002 08:14:31 +0100
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: reddog83@chartermi.net, paulkf@microgate.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.3-dj5 synclink.c fix so that it compiles
Message-ID: <20020212081431.A11779@suse.de>
In-Reply-To: <001701c1b312$24448ca0$0c00a8c0@diemos> <auto-000058467594@front1.chartermi.net> <20020212075636.T729@suse.de> <20020211.231152.130238010.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020211.231152.130238010.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11 2002, David S. Miller wrote:
>    From: Jens Axboe <axboe@suse.de>
>    Date: Tue, 12 Feb 2002 07:56:36 +0100
> 
>    On Mon, Feb 11 2002, reddog83 wrote:
>    > Paul-
>    > That is understandable. I had  the same guess as you when I made this patch. 
>    > Why is ths synclink.c driver using DMA Mapping. After I took that line out I 
>    > was fine becuase my system is fine. 
>    
>    The "real" fix for synclink is just something like this, afaics.
>    
> It is a PCI driver Jens, this change is not correct.

See my repeated follow-ups :-)

-- 
Jens Axboe

