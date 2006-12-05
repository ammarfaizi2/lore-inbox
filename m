Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937461AbWLEHEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937461AbWLEHEI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 02:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937466AbWLEHEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 02:04:08 -0500
Received: from brick.kernel.dk ([62.242.22.158]:26393 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937461AbWLEHEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 02:04:05 -0500
Date: Tue, 5 Dec 2006 08:04:48 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: -mm merge plans for 2.6.20
Message-ID: <20061205070447.GP4392@kernel.dk>
References: <20061204204024.2401148d.akpm@osdl.org> <4574FC0A.8090607@garzik.org> <20061204214114.433485fc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204214114.433485fc.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04 2006, Andrew Morton wrote:
> > 
> > > libata_resume_fix.patch
> > 
> > I thought this was resolved long ago?  Are there still open reports that 
> > this solves, where upstream doesn't work?
> 
> Heck, I don't know.

I'm not aware of any, and resume works for me. Did that patch ever get
verified as fixing something for anybody? I think it can be safely
dropped.

-- 
Jens Axboe

