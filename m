Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293531AbSCGHNo>; Thu, 7 Mar 2002 02:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293533AbSCGHNe>; Thu, 7 Mar 2002 02:13:34 -0500
Received: from ns0.auctionwatch.com ([66.7.130.2]:37637 "EHLO
	whitestar.auctionwatch.com") by vger.kernel.org with ESMTP
	id <S293531AbSCGHNQ>; Thu, 7 Mar 2002 02:13:16 -0500
Date: Wed, 6 Mar 2002 23:13:04 -0800
From: Petro <petro@auctionwatch.com>
To: Oliver.Schersand@basf-it-services.com
Cc: Alessandro Suardi <alessandro.suardi@oracle.com>, use-oracle@suse.com,
        suse-linux-e@suse.com, mason@suse.com, linux-kernel@vger.kernel.org
Subject: Re: Antwort: Re: Kernel Hangs 2.4.16 on heay io Oracle and Tivolie TSM
Message-ID: <20020307071304.GC11830@auctionwatch.com>
In-Reply-To: <OFE7517866.AA039B23-ONC1256B72.0027B52F@bcs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFE7517866.AA039B23-ONC1256B72.0027B52F@bcs.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 08:35:36AM +0100, Oliver.Schersand@BASF-IT-Services.com wrote:
> happend after about 2.5houres of backup ( about 80GB datafiles).
> After this i switched backup to kernel version 2.2.19. ---> The system runs
> now without crash.
> On other server without oracle but which are have tsm backup we had no
> problems with 2.4.16 ( at the moment  only about 15 Servers)
> 
> Its seems that you are right an we have a serious vm bug. This bug is only
> viewable if you user oracle and tsm (tivoli storage manager) .... Strange.

    Are you getting a complete OS crash, or just Oracle going bang?

-- 
Share and Enjoy. 
