Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314612AbSEFRlE>; Mon, 6 May 2002 13:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314633AbSEFRlD>; Mon, 6 May 2002 13:41:03 -0400
Received: from codepoet.org ([166.70.14.212]:7601 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S314612AbSEFRlB>;
	Mon, 6 May 2002 13:41:01 -0400
Date: Mon, 6 May 2002 11:41:01 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        "Andre M. Hedrick" <andre@linux-ide.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ for 2.4.19-pre8
Message-ID: <20020506174101.GB24013@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Jens Axboe <axboe@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	"Andre M. Hedrick" <andre@linux-ide.org>, linux-ide@vger.kernel.org
In-Reply-To: <20020506134535.GC18817@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon May 06, 2002 at 03:45:35PM +0200, Jens Axboe wrote:
> People who were (rightfully so) afraid to test 2.5 can now play with ide
> tagged queueing in 2.4. Works great here.

What sort of behavior changes should I expect to see?  Faster?
Less CPU utilization?  Are there limited set of controllers and/
or drives on which this works?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
