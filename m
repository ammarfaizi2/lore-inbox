Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276393AbRI2BIT>; Fri, 28 Sep 2001 21:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276394AbRI2BIJ>; Fri, 28 Sep 2001 21:08:09 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:34805
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S276393AbRI2BH5>; Fri, 28 Sep 2001 21:07:57 -0400
Date: Fri, 28 Sep 2001 18:08:19 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac16 good perfomer?
Message-ID: <20010928180819.A29756@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3BB3EBC1.DE9AA505@yahoo.co.uk> <Pine.LNX.4.33L.0109280049380.19147-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109280049380.19147-100000@imladris.rielhome.conectiva>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 12:50:21AM -0300, Rik van Riel wrote:
> On Thu, 27 Sep 2001, Thomas Hood wrote:
> 
> > Either 2.4.9-ac16 has much improved VM performance over
> > previous 2.4 kernels (under moderate load, at least), or someone
> > sneaked in to my apartment last night and upgraded my machine
> > while I was asleep.  I'm leaning toward the latter explanation.
> 
> Now that the -ac VM was stable for a few weeks, I thought
> it might be time to sneak in some big performance changes,
> finally.
> 
> They seem to work ;)
> 

Is it normal to have Inact_target 1/4 of main memory (64MB of 256MB RAM)?
In previous versions, this value would fluctuate with the load of the system.

Is this expected?
