Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268162AbTAKWtO>; Sat, 11 Jan 2003 17:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268165AbTAKWtO>; Sat, 11 Jan 2003 17:49:14 -0500
Received: from havoc.daloft.com ([64.213.145.173]:27352 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S268162AbTAKWtN>;
	Sat, 11 Jan 2003 17:49:13 -0500
Date: Sat, 11 Jan 2003 17:57:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, viro@math.psu.edu
Subject: Re: 2.5.56-mm1
Message-ID: <20030111225756.GA13330@gtf.org>
References: <200301111443.08527.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301111443.08527.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 02:43:08PM -0800, Andrew Morton wrote:
> - dcache-RCU.
> 
>   This was recently updated to fix a rename race.  It's quite stable.  I'm
>   not sure where we stand wrt merging it now.  Al seems to have disappeared.

I talked to him in person last week, and this was one of the topics of
discussion.  He seemed to think it was fundamentally unfixable.  He
proceed to explain why, and then explained the scheme he worked out to
improve things.  Unfortunately my memory cannot do justice to the
details.

Next time he explains it, I will write it down :)

Sorry for so lame a data point :)

	Jeff




