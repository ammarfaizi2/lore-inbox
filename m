Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292403AbSBVKML>; Fri, 22 Feb 2002 05:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292415AbSBVKMB>; Fri, 22 Feb 2002 05:12:01 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54029 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S292403AbSBVKLt>;
	Fri, 22 Feb 2002 05:11:49 -0500
Date: Fri, 22 Feb 2002 11:09:11 +0100
From: Jens Axboe <axboe@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andre Hedrick <andre@linuxdiskcert.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020222100911.GA2630@suse.de>
In-Reply-To: <Pine.LNX.4.10.10202220045100.32372-100000@master.linux-ide.org> <Pine.LNX.4.33L.0202220706540.7820-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0202220706540.7820-100000@imladris.surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22 2002, Rik van Riel wrote:
> On Fri, 22 Feb 2002, Andre Hedrick wrote:
> 
> > Please allow him to UPDATE and correct the SCSI core, also.
> > I was joking with Christoph Hellwig about his work on the SCSI API,
> > suggested he work with Martin to accellerate the rewrite.  So I am
> > inviting Martin to assist in the SCSI directory and any other place you
> > needs such an incredible grasp of your "DARWINISM" v/s logical "DESIGN".
> 
> Martin,
> 
> please tell us up-front if you are able to make Linux work
> with 48-bit IDE stuff so Linux is able to talk to drives
> larger than 137 GB.

2.5 already supports 48-bit lba addressing.

-- 
Jens Axboe

