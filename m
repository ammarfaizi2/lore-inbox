Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272531AbRIOTWB>; Sat, 15 Sep 2001 15:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272519AbRIOTVl>; Sat, 15 Sep 2001 15:21:41 -0400
Received: from femail15.sdc1.sfba.home.com ([24.0.95.142]:60159 "EHLO
	femail15.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S272520AbRIOTVg>; Sat, 15 Sep 2001 15:21:36 -0400
Date: Sat, 15 Sep 2001 15:23:19 -0400
From: Tom Vier <tmv5@home.com>
To: Dustin Marquess <jailbird@alcatraz.fdf.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH - Software RAID Autodetection for OSF partitions
Message-ID: <20010915152319.A17296@zero>
In-Reply-To: <Pine.LNX.4.33.0109090443440.369-100000@alcatraz.fdf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0109090443440.369-100000@alcatraz.fdf.net>; from jailbird@alcatraz.fdf.net on Sun, Sep 09, 2001 at 04:44:04AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i sent alan a patch for the same thing awhile ago, but he wanted to make
sure 0xfd isn't used as a type by osf/1.

On Sun, Sep 09, 2001 at 04:44:04AM -0500, Dustin Marquess wrote:
> Here's a quick patch that I wrote-up for 2.4.10-pre5 (should work with
> other 2.4.x kernels too), so that the OSF partition code should
> auto-detect partitions with a fstype of 0xFD (software RAID).

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
