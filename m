Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311641AbSCNP4Z>; Thu, 14 Mar 2002 10:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311642AbSCNP4P>; Thu, 14 Mar 2002 10:56:15 -0500
Received: from dsl-213-023-038-002.arcor-ip.net ([213.23.38.2]:18851 "EHLO
	starship") by vger.kernel.org with ESMTP id <S311641AbSCNPz7>;
	Thu, 14 Mar 2002 10:55:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jens Axboe <axboe@suse.de>, Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: [PATCH][RFT] simple deadline I/O scheduler
Date: Thu, 14 Mar 2002 16:51:12 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020104094334.N8673@suse.de> <E16l8sQ-0000EX-00@starship> <20020314073216.GB30351@suse.de>
In-Reply-To: <20020314073216.GB30351@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16lXVY-0000Rn-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 14, 2002 08:32 am, Jens Axboe wrote:
> On Wed, Mar 13 2002, Daniel Phillips wrote:
> > Andrew Morton is also working in here, with a collection of ideas that I hope 
> > are complementary if looked at the right way.  See his '[patch] delayed disk 
> > block allocation' post.
> 
> Right, I noticed. We could get good write clustering in general with vm
> merging, though.

Sorry, I can't parse that, do you mean 'if the elevator merging is merged with
vm's' or 'if vm does merging' or... ?

-- 
Daniel
