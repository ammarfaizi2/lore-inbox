Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289578AbSBEPC1>; Tue, 5 Feb 2002 10:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289568AbSBEPCR>; Tue, 5 Feb 2002 10:02:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25094 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289564AbSBEPCH>;
	Tue, 5 Feb 2002 10:02:07 -0500
Date: Tue, 5 Feb 2002 15:42:34 +0100
From: Jens Axboe <axboe@suse.de>
To: Momchil Velikov <velco@fadata.bg>
Cc: Ralf Oehler <R.Oehler@GDAmbH.com>, Scsi <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>,
        Jens Axboe <axboe@kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: one-line-patch against SCSI-Read-Error-BUG()
Message-ID: <20020205154234.B16105@suse.de>
In-Reply-To: <XFMail.20020205153210.R.Oehler@GDAmbH.com> <20020205152434.A16105@suse.de> <871yg07zg4.fsf@fadata.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871yg07zg4.fsf@fadata.bg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05 2002, Momchil Velikov wrote:
> >>>>> "Jens" == Jens Axboe <axboe@suse.de> writes:
> 
> Jens> On Tue, Feb 05 2002, Ralf Oehler wrote:
> >> Hi, List
> >> 
> >> I think, I found a very simple solution for this annoying BUG().
> 
> Jens> You fail to understand that the BUG triggering indicates that their is a
> Jens> BUG _somewhere_ -- the triggered BUG is not the bug itself, of course,
> Jens> that would be stupid :-)
> 
> Erm, having a BUG() somewhere can be a bug by itself ;)
> 
> I think that's what he meant (regardless if he was right or not). 

Of course it can, any statement can be a bug. That's hardly the point
:-)

-- 
Jens Axboe

