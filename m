Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285878AbRLHIx0>; Sat, 8 Dec 2001 03:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282933AbRLHIxR>; Sat, 8 Dec 2001 03:53:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:50189 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285878AbRLHIw4>;
	Sat, 8 Dec 2001 03:52:56 -0500
Date: Sat, 8 Dec 2001 09:52:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Would the father of init_mem_lth please stand up
Message-ID: <20011208085251.GI32569@suse.de>
In-Reply-To: <20011207234048.A31442@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011207234048.A31442@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07 2001, Pete Zaitcev wrote:
> Really someone needs slapping across. What kind of code is that
> (in 2.5.1-pre6):

It went in with the bio stuff, without being too much of a
finger-pointer I think it is Andries.

> No doubt, the existing code was bad. I fixed it somewhat for 2.4,
> and am feeding it to Marcelo. I can forward-port that to 2.5
> if anyone is interested.

Please, just fix it in 2.5 too.

-- 
Jens Axboe

