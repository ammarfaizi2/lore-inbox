Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262727AbSJCE2X>; Thu, 3 Oct 2002 00:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262725AbSJCE2W>; Thu, 3 Oct 2002 00:28:22 -0400
Received: from [202.88.156.6] ([202.88.156.6]:2761 "EHLO saraswati.hathway.com")
	by vger.kernel.org with ESMTP id <S262727AbSJCE2W>;
	Thu, 3 Oct 2002 00:28:22 -0400
Date: Thu, 3 Oct 2002 09:54:59 +0530
From: Dipankar Sarma <dipankar@gamebox.net>
To: Guillaume Boissiere <boissiere@adiglobal.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  October 2, 2002
Message-ID: <20021003095459.A7473@dikhow>
Reply-To: dipankar@gamebox.net
References: <3D9B2FBD.12828.5DF75E@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D9B2FBD.12828.5DF75E@localhost>; from boissiere@adiglobal.com on Wed, Oct 02, 2002 at 11:50:11PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 11:50:11PM +0200, Guillaume Boissiere wrote:
> ---------------------------------------------
> Linux Kernel 2.5 Status - October 2nd, 2002
> (Latest kernel release is 2.5.40)
> 
> Items in bold have changed since last week.
> Items in grey are post Halloween (feature freeze).
> 
> Cleanups:  
>  
> Merged  
> o Beta  Remove dcache_lock  (Maneesh Soni, IBM team)  

FYI, this is in -mm since 2.5.37-mm1. The description is more like
"Avoid dcache_lock while path walking".

Thanks
Dipankar
