Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278887AbRKANAd>; Thu, 1 Nov 2001 08:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278902AbRKANAW>; Thu, 1 Nov 2001 08:00:22 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:4343
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278887AbRKANAR>; Thu, 1 Nov 2001 08:00:17 -0500
Date: Thu, 1 Nov 2001 05:00:07 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] correct cached statistics
Message-ID: <20011101050007.C1346@mikef-linux.matchmail.com>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0110311314270.2963-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0110311314270.2963-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 01:16:15PM -0200, Rik van Riel wrote:
> Hi,
> 
> it seems a small change from the blockdev-in-pagecache changes
> has crept into 2.4.13-ac, the following patch backs out that
> change and should make the cached stats correct again.
> 
> Please apply for the next one.
> 
> thanks,
> 

Will this work on linus kernels too?  I'm seeing this on:
Now  : 01:36:51 running Linux
   2.4.14-pre6+preempt+netdev_random+ext3_0.9.14-2414p5
   
Mike
