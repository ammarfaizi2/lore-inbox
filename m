Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317378AbSGDIz3>; Thu, 4 Jul 2002 04:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317379AbSGDIz2>; Thu, 4 Jul 2002 04:55:28 -0400
Received: from mail12.svr.pol.co.uk ([195.92.193.215]:48678 "EHLO
	mail12.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S317378AbSGDIz2>; Thu, 4 Jul 2002 04:55:28 -0400
Date: Thu, 4 Jul 2002 09:57:35 +0100
To: Jens Axboe <axboe@kernel.org>
Cc: Andrew Morton <akpm@zip.com.au>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-lvm@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] LVM2 modifies the buffer_head struct?
Message-ID: <20020704085735.GA1175@fib011235813.fsnet.co.uk>
References: <F19741gcljD2E2044cY00004523@hotmail.com> <20020702141702.GA9769@fib011235813.fsnet.co.uk> <20020703100838.GH14097@suse.de> <20020703120124.GB615@fib011235813.fsnet.co.uk> <20020703121024.GC21568@suse.de> <15651.54044.557070.109158@notabene.cse.unsw.edu.au> <20020704075830.GQ21568@suse.de> <3D2409FA.44E88C1D@zip.com.au> <20020704083941.GA6204@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020704083941.GA6204@suse.de>
User-Agent: Mutt/1.3.28i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2002 at 10:39:41AM +0200, Jens Axboe wrote:
> Which just means that device mapper needs to do the stacking properly,
> EOD.

You don't think it does it properly ATM ?

- Joe
