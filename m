Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281081AbRKOVkj>; Thu, 15 Nov 2001 16:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281083AbRKOVk3>; Thu, 15 Nov 2001 16:40:29 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:59118
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281081AbRKOVkX>; Thu, 15 Nov 2001 16:40:23 -0500
Date: Thu, 15 Nov 2001 13:40:17 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Anders Peter Fugmann <afu@fugmann.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Scheduler
Message-ID: <20011115134017.B23386@mikef-linux.matchmail.com>
Mail-Followup-To: Anders Peter Fugmann <afu@fugmann.dhs.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BF415F2.2010204@fugmann.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BF415F2.2010204@fugmann.dhs.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2001 at 08:22:26PM +0100, Anders Peter Fugmann wrote:
> Hi all.
> 
> I'm about to start my master thesis, and for this I'm thinking of 
> implementing a new scheduler for Linux.
> 
> The project will be mostly theoretical, and I'm therefore looking for 
> pointers to papers describing schduling methods for SMP systems.
> 
> As a part of the project will be to implement a new scheduler, I also 
> would like to know if any of you have some good pointers to eksisting 
> scheduling projects.
> 

goto kernelnewbies.org/patches/ and search for "sched".

It'll list all of them that I know about except for the MQ secheduler.

Mike
