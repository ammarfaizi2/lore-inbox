Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266629AbRGEGea>; Thu, 5 Jul 2001 02:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266633AbRGEGeT>; Thu, 5 Jul 2001 02:34:19 -0400
Received: from stine.vestdata.no ([195.204.68.10]:3603 "EHLO stine.vestdata.no")
	by vger.kernel.org with ESMTP id <S266629AbRGEGeJ>;
	Thu, 5 Jul 2001 02:34:09 -0400
Date: Thu, 5 Jul 2001 08:34:02 +0200
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Ben LaHaise <bcrl@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010705083402.D11805@vestdata.no>
In-Reply-To: <20010703065312.J4841@vestdata.no> <Pine.LNX.4.33.0107032211120.30968-100000@toomuch.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5i
In-Reply-To: <Pine.LNX.4.33.0107032211120.30968-100000@toomuch.toronto.redhat.com>; from Ben LaHaise on Tue, Jul 03, 2001 at 10:19:36PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2001 at 10:19:36PM -0400, Ben LaHaise wrote:
> > > [ patch to make md and nbd work for >2TB devices ]
> > What about LVM?
> 
> Errr, I'll refrain from talking about LVM.

What do you mean?
Is it not feasible to fix this in LVM as well, or do you just not know
what needs to be done to LVM?


-- 
Ragnar Kjorstad
Big Storage
