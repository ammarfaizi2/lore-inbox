Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318704AbSIKK31>; Wed, 11 Sep 2002 06:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318706AbSIKK30>; Wed, 11 Sep 2002 06:29:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29334 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318704AbSIKK30>;
	Wed, 11 Sep 2002 06:29:26 -0400
Date: Wed, 11 Sep 2002 12:34:11 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Knoblauch <martin.knoblauch@mscsoftware.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Oops + Aiee when mounting CDROM via ide-scsi under 2.4.20-pre5-ac4
Message-ID: <20020911103411.GA1089@suse.de>
References: <200209111228.15954.martin.knoblauch@mscsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209111228.15954.martin.knoblauch@mscsoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11 2002, Martin Knoblauch wrote:
> > ok try this patch, against 2.4.20-pre5-ac4 (well not a clean one, but 
> > I think it should apply). 
> > 
> > 
> > alan, this should probably go into ac5 provided that Martin tests it
> > as ok. 
> Jens, Alan.
> 
>  BBW (Boots, Builds, Works :-). Thanks you very much. After the patch 
> mounting CD's through ide-scsi works like a charm.
> 
>  So, from my point of view it should go into pre5-ac5 or pre6-ac1.

Thanks for testing, glad to hear it.

-- 
Jens Axboe

