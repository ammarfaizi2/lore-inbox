Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272613AbRHaF43>; Fri, 31 Aug 2001 01:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272617AbRHaF4M>; Fri, 31 Aug 2001 01:56:12 -0400
Received: from fe100.worldonline.dk ([212.54.64.211]:55050 "HELO
	fe100.worldonline.dk") by vger.kernel.org with SMTP
	id <S272612AbRHaF4E>; Fri, 31 Aug 2001 01:56:04 -0400
Date: Fri, 31 Aug 2001 07:56:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Jonathan Lahr <lahr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: io_request_lock/queue_lock patch
Message-ID: <20010831075613.A2855@suse.de>
In-Reply-To: <20010830134930.F23680@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010830134930.F23680@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30 2001, Jonathan Lahr wrote:
> 
> Included below is a snapshot of a patch I am developing to reduce 
> io_request_lock contention in 2.4.  

No no no, you are opening a serious can of worms. No offense, but did
you really think this would fly?! This is already being taken care of
for 2.5, lets leave 2.4 alone in this regard.

-- 
Jens Axboe

