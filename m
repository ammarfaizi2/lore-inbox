Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272618AbRHaF6L>; Fri, 31 Aug 2001 01:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272617AbRHaF5y>; Fri, 31 Aug 2001 01:57:54 -0400
Received: from fe030.worldonline.dk ([212.54.64.197]:41997 "HELO
	fe030.worldonline.dk") by vger.kernel.org with SMTP
	id <S272615AbRHaF5A>; Fri, 31 Aug 2001 01:57:00 -0400
Date: Fri, 31 Aug 2001 07:57:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Jonathan Lahr <lahr@us.ibm.com>
Cc: Eric Youngdale <eric@andante.org>,
        =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: io_request_lock/queue_lock patch
Message-ID: <20010831075708.B2855@suse.de>
In-Reply-To: <20010830232228.C2120-100000@gerard> <008801c1319d$57f16970$4d0310ac@fairfax.mkssoftware.com> <20010830160708.G23680@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010830160708.G23680@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30 2001, Jonathan Lahr wrote:
> 
> Is there an estimate on when the 2.5 i/o subsystem will be released?

I've at least put up incremental patches of what I'm doing here:

kernel.org/pub/linux/kernel/people/axboe/v2.5

bio-14 will be final next week.

-- 
Jens Axboe

