Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312441AbSCUSTY>; Thu, 21 Mar 2002 13:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312440AbSCUSTD>; Thu, 21 Mar 2002 13:19:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62725 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S312429AbSCUSTA>;
	Thu, 21 Mar 2002 13:19:00 -0500
Date: Thu, 21 Mar 2002 19:18:25 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mike Fedyk <mfedyk@matchmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][CFT] CD-MRW (Mt Rainier) support
Message-ID: <20020321181825.GX1659@suse.de>
In-Reply-To: <20020321175944.GC3201@matchmail.com> <E16o7Hc-0005vH-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21 2002, Alan Cox wrote:
> > On Thu, Mar 21, 2002 at 02:12:01PM +0100, Jens Axboe wrote:
> > > # ./mtr -d /dev/hdc -f full
> > 
> > You may need to rename this biary since I think some other tools use this
> > name also...
> 
> Yes - mtr is a graphical/text mode trace route/ping/etc tool

Ok for the record, I've gotten 10 of these now. Does anyone have
constructive comments besides the name (which I have changed now)? :-)

-- 
Jens Axboe

