Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288092AbSAMURg>; Sun, 13 Jan 2002 15:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288093AbSAMUR0>; Sun, 13 Jan 2002 15:17:26 -0500
Received: from zeus.kernel.org ([204.152.189.113]:51364 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S288092AbSAMURI>;
	Sun, 13 Jan 2002 15:17:08 -0500
Date: Sun, 13 Jan 2002 11:59:15 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jens Axboe <axboe@suse.de>
cc: Andre Hedrick <andre@linuxdiskcert.org>, linux-kernel@vger.kernel.org
Subject: Re: BIO Usage Error or Conflicting Designs
In-Reply-To: <20020113135927.A11793@suse.de>
Message-ID: <Pine.LNX.4.10.10201131157590.15103-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jan 2002, Jens Axboe wrote:

> On Sat, Jan 12 2002, Andre Hedrick wrote:
> > 
> > Jens,
> > 
> > Here is back at you sir.
> 
> Without highmem debug enabled?? I already knew this was the bug
> triggered, nothing new here.
> 
> Please print the two pfn values triggering the BUG_ON, I'll take a look
> at this tomorrow.

That is with highmem debug on, the stuff at the end of the config file.
Nothing more is generated, if there are more flags to set please tell me
where.

Regards,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

