Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284246AbRLUOrr>; Fri, 21 Dec 2001 09:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284573AbRLUOrh>; Fri, 21 Dec 2001 09:47:37 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53510 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284246AbRLUOrb>;
	Fri, 21 Dec 2001 09:47:31 -0500
Date: Fri, 21 Dec 2001 15:46:54 +0100
From: Jens Axboe <axboe@kernel.org>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 dbench 32 hangs in vmstat "b" state
Message-ID: <20011221154654.E811@suse.de>
In-Reply-To: <20011221091104.A120@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011221091104.A120@earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21 2001, rwhron@earthlink.net wrote:
> While running "dbench 32" on 2.5.2-pre1:
> 
> I noticed the test was taking much longer than usual,
> and I could not do a new "login".  
> 
> vmstat 8 looked like this:

You neglected to mention what disk I/O system you are using? IDE or
SCSI, and if the latter what host adapter?

-- 
Jens Axboe

